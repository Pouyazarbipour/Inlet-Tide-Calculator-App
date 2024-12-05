classdef InletApp < handle
    properties
        fig         % Main figure window
        panel1      % Input panel
        graph1      % Axes for plotting
        inputs      % Input fields
    end
    
    methods
        function obj = InletApp()
            % Constructor: Initialize and create UI
            obj.init();
        end
        
        function init(obj)
            % Create the main figure window
            obj.fig = figure('Name', 'Inlet Calculator', 'NumberTitle', 'off', ...
                'Position', [100, 100, 800, 600]);
            
            % Create main vertical layout using panels
            graphPanel = uipanel('Parent', obj.fig, 'Position', [0 0.3 1 0.7]);
            inputPanel = uipanel('Parent', obj.fig, 'Position', [0 0 1 0.3]);
            
            % Graph container
            obj.graph1 = axes('Parent', graphPanel, ...
                'Position', [0.1 0.2 0.8 0.7], ...
                'Box', 'on', 'XGrid', 'on', 'YGrid', 'on');
            title(obj.graph1, 'Wave Response');
            xlabel(obj.graph1, 'Time (s)');
            ylabel(obj.graph1, 'Amplitude');
            
            % Create input panel
            obj.panel1 = obj.createPanel(inputPanel);
        end
        
        function panel = createPanel(obj, parent)
            % Define input labels and default values
            inputs = {
                'Inlet Depth (m)', 'InletDepth', '6.0';
                'Inlet Width (m)', 'InletWidth', '100.0';
                'Inlet Length (m)', 'InletLength', '1000.0';
                'Bay Planform Area (km²)', 'BayPlanformArea', '50.0';
                'Ocean Tide Amplitude (m)', 'OceanTideAmplitude', '1.0'
            };

            obj.inputs = struct();

            % Manually position labels and input fields
            labelWidth = 150;
            inputWidth = 100;
            rowHeight = 40;
            startX = 50;
            startY = 200;

            for i = 1:size(inputs, 1)
                % Label
                uicontrol('Parent', parent, 'Style', 'text', ...
                    'String', inputs{i, 1}, ...
                    'Position', [startX, startY - (i - 1) * rowHeight, labelWidth, 30], ...
                    'HorizontalAlignment', 'right', ...
                    'FontSize', 10);

                % Input field
                obj.inputs.(inputs{i, 2}) = uicontrol('Parent', parent, 'Style', 'edit', ...
                    'Position', [startX + labelWidth + 10, startY - (i - 1) * rowHeight, inputWidth, 30], ...
                    'String', inputs{i, 3}, ...
                    'FontSize', 10);
            end

            % Add buttons
            uicontrol('Parent', parent, 'Style', 'pushbutton', ...
                'Position', [startX, 20, 150, 30], ...
                'String', 'Calculate', ...
                'Callback', @(~, ~) obj.calculateTide(), ...
                'FontSize', 10);
            uicontrol('Parent', parent, 'Style', 'pushbutton', ...
                'Position', [startX + 200, 20, 150, 30], ...
                'String', 'Reset', ...
                'Callback', @(~, ~) obj.resetForm(), ...
                'FontSize', 10);

            panel = parent;
        end
        
        function calculateTide(obj)
            % Perform tidal wave calculations
            try
                % Retrieve user inputs
                d = str2double(obj.inputs.InletDepth.String);
                W = str2double(obj.inputs.InletWidth.String);
                el = str2double(obj.inputs.InletLength.String);
                A = str2double(obj.inputs.BayPlanformArea.String) * 1e6; % Convert to m^2
                ao = str2double(obj.inputs.OceanTideAmplitude.String);
                
                % Constants
                g = 9.81;          % Gravity (m/s^2)
                sig = 2 * pi / 45144; % Tide frequency (rad/s)
                Ken = 0.2;         % Entrance loss coefficient
                Kex = 1.0;         % Exit loss coefficient
                
                % Calculations
                Rh = d * W / (W + 2 * d); % Hydraulic radius
                f = 0.01; % Friction factor
                denom = sqrt(Ken + Kex + f * el / (4 * Rh));
                K = W * d * sqrt(2 * g * ao) / (sig * ao * A * denom);
                
                % Runge-Kutta wave calculation
                [time, etao, etab] = obj.rungeKutta(K);
                
                % Plot results
                obj.plotWaves(time, etao, etab, K);
                
            catch ME
                % Error handling
                errordlg(ME.message, 'Input Error');
            end
        end
        
        function [time, etao, etab] = rungeKutta(~, K)
            % Perform Runge-Kutta wave response calculation
            dt = pi / 30;
            time = (0:dt:(239 * dt))'; % Time vector
            
            etao = sin(time); % Ocean tide
            etab = zeros(size(time)); % Bay tide initialization
            
            for i = 1:(length(time) - 1)
                t = time(i);
                arg = etao(i) - etab(i);
                yp1 = dt * K * sqrt(abs(arg)) * sign(arg);
                etaohalf = sin(t + dt / 2);
                arg = etaohalf - (etab(i) + yp1 / 2);
                yp2 = dt * K * sqrt(abs(arg)) * sign(arg);
                arg = etaohalf - (etab(i) + yp2 / 2);
                yp3 = dt * K * sqrt(abs(arg)) * sign(arg);
                arg = sin(t + dt) - (etab(i) + yp3);
                yp4 = dt * K * sqrt(abs(arg)) * sign(arg);
                etab(i + 1) = etab(i) + (yp1 + 2 * yp2 + 2 * yp3 + yp4) / 6;
            end
            
            % Truncate results for the last 60 values
            time = time(end-59:end);
            etao = etao(end-59:end);
            etab = etab(end-59:end);
        end
        
        function plotWaves(obj, time, etao, etab, K)
            % Plot wave responses
            axes(obj.graph1);
            cla(obj.graph1); % Clear previous plot
            
            plot(time, etao, 'b-', 'DisplayName', 'Ocean Wave');
            hold on;
            plot(time, etab, 'k--', 'DisplayName', 'Bay Wave');
            legend('show');
            
            title(sprintf('Wave Response (K = %.2f)', K));
            xlabel('Time (s)');
            ylabel('Amplitude (m)');
        end
        
        function resetForm(obj)
            % Reset all input fields to default values
            obj.inputs.InletDepth.String = '6.0';
            obj.inputs.InletWidth.String = '100.0';
            obj.inputs.InletLength.String = '1000.0';
            obj.inputs.BayPlanformArea.String = '50.0';
            obj.inputs.OceanTideAmplitude.String = '1.0';
        end
    end
end
