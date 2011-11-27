function PlaceScalebar(pixelSize,magnification)

    %% Grab width and height from the plot
    imageWidth  = abs(diff(get(gca,'XLim')));
    imageHeight = abs(diff(get(gca,'YLim')));


    %% Determine the size of the scalebar
    %  We want the width of the scalebar to be approximately 25% of the width
    %  of the image. Furthermore do we want the scalebar to represent an
    %  integer number of units (1 um, 2 um, 10 um, 100 nm,...). Therefore we
    %  first see what the what size we represent if the scalebar is 25% of the
    %  width of the image, and then find the closest integer number.
    startSize = .25*imageWidth * (pixelSize/magnification);
    
    % Find the power of ten we need, going from 1 nm to 100 mm
    for j=-6:3
        if floor(startSize *10^(j)) >= 1
            break; %will exit the loop
        end
    end

    % Set the unit
    if (j > 0) && (j <= 3)
        sizeUnit = 'nm';
        powerTen = 3;
    elseif (j > -3) && (j <= 0)
        sizeUnit = '\mum';
        powerTen = 0;
    elseif (j > -6) && (j <= -3)
        sizeUnit = 'mm';
        powerTen = -3;
    end

    % Set the size
    sizeBar = round(startSize *10^(j)) .*10^(-j) .*10^(powerTen);
    
    
    scaleWidth = sizeBar .*10^(-powerTen) * (magnification/pixelSize);
    scaleHeight = scaleWidth / 6;

    scaleXPos   = round( imageWidth - (.075*imageHeight) - scaleWidth );
    scaleYPos   = round( imageHeight - (.075*imageHeight) - scaleHeight );

    textXPos    = scaleXPos + 0.5*scaleWidth;
    textYPos    = scaleYPos - 1*scaleHeight;
    rectangle('Position', [scaleXPos, scaleYPos, scaleWidth, scaleHeight],'FaceColor',[1 1 0.99]);
    text(textXPos, textYPos,[num2str(sizeBar) ' ' sizeUnit], 'Fontsize', 30, 'HorizontalAlignment', 'Center','Color',[1 1 0.99]);
end


