%--------------------------------------------------------------------------
% Create figure window with specific properties (optional log information)
%--------------------------------------------------------------------------
%
%   CreateFigure, by itself, creates a new figure window with default 
%   properties which can be use for logbooks figures. It also returns its 
%   handle.
% 
%   CreateFigure(type) allows you to specify a specific use for the figure,
%   so that the properties can be set accordingly. Options for type are
%   now:
%   type = 'A3'             Large fonts, large lines and markers. We also 
%                           add debug information.
%   type = 'Article'        Fonts, lines and markers tailored for articles.
%                           No debug information.
%   type = 'Log' (default)  Medium fonts, medium lines and markers. We also
%                           add debug information
%   
%--------------------------------------------------------------------------
%   Author:     Elbert van Putten
%   Date:       12 January 2010
%   Revision:   1.0
%--------------------------------------------------------------------------

function figure1 = CreateFigure(type)
    % If no argument is given we set type to the default value
    if nargin == 0
        % Set 'Log' as our default value
        type = 'Log';
    end
    % Convert type to lowercase
    type = lower(type);

    % Set the type specific properties for the figure
    switch type
        case 'article'
            FontSize = 15;
            DefaultLineWidth = 1;
            MarkerSize = 10;
            LogInfo = 0;
        case 'a3'
            FontSize = 45;
            DefaultLineWidth = 5;
            MarkerSize = 15;
            LogInfo = 1;
        case 'log'
            FontSize = 16;
            DefaultLineWidth = 3;
            MarkerSize = 10;
            LogInfo = 1;    
    end
    
    set(0,...
    'DefaultFigurePaperType','A4',...
    'DefaultFigureUnits','centimeters',...
    'DefaultFigurePosition',[1, 2, 29.7, 21.0],...
    'DefaultTextFontSize',FontSize,...
    'DefaultAxesBox','on',...
    'DefaultAxesFontSize',FontSize);
    
    
    % Open the figure
    figure1 = figure('PaperType','a4','PaperOrientation', 'landscape');

    set(gcf,'DefaultLineLineWidth',DefaultLineWidth)
    set(gcf,'DefaultLineMarkerSize',MarkerSize);
    set(gcf,'Units','centimeters');

    % Add visible log information if needed
    if LogInfo
        AddLogInfo(figure1,1);
    else
        AddLogInfo(figure1,0);
    end
end

function AddLogInfo(figure,visible)
    global path;
    if isempty(path)
        userData.path = 'Not Available';
    else
        userData.path = path;
    end

    % Grab name of the main m-file using dbstack
    userData.stackInfo = dbstack('-completenames');
    if size(userData.stackInfo,1) >= 3
        userData.mainFile = userData.stackInfo(end).file;        
    else 
        userData.mainFile = 'Called from Command Window';
    end

    % Create a time stamp
    userData.date = now;
    
    % Place textbox at the bottom of the figure
    if visible
        str = strcat(sprintf('Date: '),datestr(userData.date),sprintf('\nData path: '),char(userData.path),sprintf('\nUsed m-file: '),userData.mainFile);
        str = regexprep(str,'\', '\\\');
                str = regexprep(str,'_', '\\_');
        annotation('textbox',[0,0,1,.04],...
         'String',str,...
         'HorizontalAlignment','Center',...
         'VerticalAlignment','Middle',...
         'FontSize',7);
    end
    
    % Add loginfo to figure userdata
    set(figure,'UserData',userData);
end