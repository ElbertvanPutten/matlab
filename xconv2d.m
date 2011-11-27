%--------------------------------------------------------------------------
% Author:        Elbert van Putten
% Date:          04/01/2009
% Last modified: 21/07/2010 
% Task:          Calculate a cross convolution in Fourier space
% Changelist:    - No longer subtract the mean value, this should be done
%                  before you call this command
%                - No longer normalize because the normalization is not
%                  well defined if the two images have different means
%--------------------------------------------------------------------------

function conv2d = xconv2d(imageA,imageB)
    % calculate the Fourier transform of the images
    imageA_ft = fft2(imageA);
    imageB_ft = fft2(imageB);

    % multiply the FT of image1 with the FT of image2 and Fourier transform
    % back
    conv2d = fftshift(ifft2( imageA_ft .* imageB_ft ));
end
