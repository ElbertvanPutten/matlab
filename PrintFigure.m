%
%
% Todo
% Store workspace (How to do this when working in a
% sub m-file?
function PrintFigure(figureHandle)
    % The base path for all the figures. Think its better to store them
    % under one folder than place them in the data folder..
    % This path will be different for everybody
    basepath = 'Z:\Figures\';

    if nargin == 0
        % set handle to current figure
        figureHandle = gcf;
    end
    
    % Retrive userdata from the figure;
    userData = get(figureHandle,'UserData');
    
    % Generate folder and filenames
    [y, m, d, h, mn, s] = datevec(userData.date);
    if m < 10
       m = ['0' char(num2str(m))];
    else
       m = char(num2str(m));
    end
    if d < 10
       d = ['0' char(num2str(d))];
    else
       d = char(num2str(d));
    end    
    s = floor(s);
    y = char(num2str(y));
    y = [y(3) y(4)];
    dateFolder = [sprintf('%s%s%s',y,m,d) '\'];
    timeFolder = [sprintf('%dh%dm%ds',h,mn,s) '\'];
    timeFilename = sprintf('%dh%dm%ds',h,mn,s);
    
    % Create a new date folder if it does not exist yet
    path = [basepath dateFolder];
    if exist(path) == 0
        mkdir(basepath,dateFolder);
    end
    
    % Check if the time folder already exists
    path = [basepath dateFolder timeFolder];
    if exist(path) == 0
        mkdir([basepath dateFolder],timeFolder);
    else
        
    end
    
    set(figureHandle,'PaperOrientation','landscape', 'PaperType' ,'A4', 'PaperUnits' ,'Normalized', 'PaperPosition', [0 0 1 1])
    % Store the figure in different formats
    print(figureHandle,'-depsc2','-r300','-tiff',[path timeFilename '-tiff.eps'])
    print(figureHandle,'-depsc2','-r300',[path timeFilename '.eps'])
    print(figureHandle,'-dpdf','-r300',[path timeFilename '.pdf'])
    print(figureHandle,'-djpeg','-r300',[path timeFilename '.jpg'])
    saveas(figureHandle,[path timeFilename '.fig'])
    % Store a jpeg in the dateFolder to quickly scan the figures
    print(figureHandle,'-djpeg',[path '..\' timeFilename '.jpg'])
    
   
    % Store the current workspace
    save([path timeFilename '.mat'])
    
    
    % Store all the m-files that were running during the creation of the
    % figure. We start at i=3 because the first two entries are always
    % CreateFigure
    for i = 3:size(userData.stackInfo,1)
        userData.stackInfo(i).file
        copyfile(userData.stackInfo(i).file,path);
    end

    % Open pdf file for printing
    %printpreview
    open([path timeFilename '.pdf']);
        
end