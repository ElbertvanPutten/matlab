%--------------------------------------------------------------------------
% Author:        Elbert van Putten
% Date:          22/07/2010
% Last modified: 22/07/2010 
% Task:          Deconvolutes a imageA with imageB in Fourier space
%
%--------------------------------------------------------------------------

function decorr2d = xdecorr2d(imageA,imageB)
    % calculate the Fourier transform of the images
    imageA_ft = fft2(imageA);
    imageB_ft = fft2(imageB);

    % Divide the FT of image1 with the conjugate of the FT of image2 and
    % Fourier transform back
    decorr2d_ft = (imageA_ft .* imageB_ft) ./ (imageB_ft.*conj(imageB_ft));
    decorr2d = fftshift(ifft2( decorr2d_ft ));
end