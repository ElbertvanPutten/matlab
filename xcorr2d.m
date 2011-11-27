%--------------------------------------------------------------------------
% Author:        Elbert van Putten
% Date:          04/01/2009
% Last modified: 16/10/2010 
% Task:          Calculate a cross correlation between imageA and imageB using
%                Fourier space. This method therefore assumes that both images
%                repeat themselves indefinitely.
% Changelist:    - Removed the fftshift in the last line
%                - One argument now means autocorrelation
%                - No longer subtract the mean value, this should be done
%                  before you call this command
%                - No longer normalize because the normalization is not
%                well defined if the two images have different means
%--------------------------------------------------------------------------

function corr2d = xcorr2d(imageA,imageB)
    % If only one argument is given we will take the autocorrelate
    if nargin == 1
        imageB = imageA;
    end
    
    % calculate the Fourier transform of the images
    imageA_ft = fft2(imageA);
    imageB_ft = fft2(imageB);

    % multiply the FT of image1 with the conjugate of the FT of image2 and
    % Fourier transform back
    corr2d = ifft2( imageA_ft .* conj(imageB_ft) );
end
