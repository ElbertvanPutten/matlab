function handle = figure(varargin)
    %  FIGURE overloaded function for builtin FIGURE function
    %     When no argument is given, we overload the builtin function 'figure' in
    %     order to change the default layout and add log information

    
    % Check for the absence of arguments
    if (nargin == 0)
        % Initialize layout parameters
        fontSize = 20;
        defaultLineWidth = 3;
        markerSize = 10;
        colorOrder = [0.0783 0.1686 0.549; % Navy blue
                      0.8471 0.1608 0;     % Wine red
                      0 0.498 0];          % Olive green
    
        % Create the figure, A4 and landscape
        handle = builtin('figure','PaperType','a4','PaperOrientation', 'landscape');
        
        % Set layout
        set(handle,...
           'Units','centimeters',...
           'Position',[1, 2, 29.7, 21.0],...
           'DefaultTextFontSize',fontSize,...
           'DefaultAxesBox','on',...
           'DefaultAxesFontSize',fontSize,...
           'DefaultLineLineWidth',defaultLineWidth,...
           'DefaultAxesColorOrder',colorOrder,...
           'DefaultLineMarkerSize',markerSize);
        
        % Add extra information to the figure
%        AddLogInfo(handle);
    else
         disp('Using builtin figure');
         % If any arguments were given, we use directly the builtin figure
         handle = builtin('figure',varargin{:});
     end 
end

% function AddLogInfo(handle)
%      global path;
%      if isempty(path)
%          userData.path = 'Not Available';
%      else
%          userData.path = path;
%      end
%  
%      % Grab name of the main m-file using dbstack
%      userData.stackInfo = dbstack('-completenames');
%      if size(userData.stackInfo,1) >= 3
%          userData.mainFile = userData.stackInfo(end).file;        
%      else 
%          userData.mainFile = 'Called from Command Window';
%      end
%  
%      % Create a time stamp
%      userData.date = now;
%      
%      % Place textbox at the bottom of the figure
%      str = strcat(sprintf('Date: '),datestr(userData.date),sprintf('\nData path: '),char(userData.path),sprintf('\nUsed m-file: '),userData.mainFile);
%      str = regexprep(str,'\', '\\\');
%      str = regexprep(str,'_', '\\_');
%      annotation('textbox',[0,0,1,.04],...
%                 'String',str,...
%                 'HorizontalAlignment','Center',...
%                 'VerticalAlignment','Middle',...
%                 'FontSize',7);
%      
%      % Add loginfo to figure userdata
%      set(handle,'UserData',userData);
%  end