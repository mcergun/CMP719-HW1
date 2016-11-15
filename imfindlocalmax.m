function [outim outim2] = imfindlocalmax(im, orgim)
outim = size(im);
outim = im > imdilate(im, [1 1 1; 1 0 1; 1 1 1]);
outim2 = orgim;
for n=6:size(im,1)-6
  for m=6:size(im,2)-6
    if outim(n,m)
      outim2(n-5, m-5) = 1;
      outim2(n-4, m-5) = 1;
      outim2(n-3, m-5) = 1;
      outim2(n-2, m-5) = 1;
      outim2(n-1, m-5) = 1;
      outim2(n, m-5) = 1;
      outim2(n+1, m-5) = 1;
      outim2(n+2, m-5) = 1;
      outim2(n+3, m-5) = 1;
      outim2(n+4, m-5) = 1;
      outim2(n+5, m-5) = 1;
      outim2(n-5, m-4) = 1;
      outim2(n+5, m-4) = 1;
      outim2(n-5, m-3) = 1;
      outim2(n+5, m-3) = 1;
      outim2(n-5, m-2) = 1;
      outim2(n+5, m-2) = 1;
      outim2(n-5, m-1) = 1;
      outim2(n+5, m-1) = 1;
      outim2(n-5, m) = 1;
      outim2(n+5, m) = 1;
      outim2(n-5, m + 1) = 1;
      outim2(n+5, m + 1) = 1;
      outim2(n-5, m + 2) = 1;
      outim2(n+5, m + 2) = 1;
      outim2(n-5, m + 3) = 1;
      outim2(n+5, m + 3) = 1;
      outim2(n-5, m + 4) = 1;
      outim2(n+5, m + 4) = 1;      
      outim2(n-5, m+5) = 1;
      outim2(n-4, m+5) = 1;
      outim2(n-3, m+5) = 1;
      outim2(n-2, m+5) = 1;
      outim2(n-1, m+5) = 1;
      outim2(n, m+5) = 1;
      outim2(n+1, m+5) = 1;
      outim2(n+2, m+5) = 1;
      outim2(n+3, m+5) = 1;
      outim2(n+4, m+5) = 1;
      outim2(n+5, m+5) = 1;
    end
  end
end   
end