barbara  = imread('images/barbara.png');  barbara_name  = "barbara";
lenna    = imread('images/lenna.png');    lenna_name    = "lenna";
mandrill = imread('images/mandrill.png'); mandrill_name = "mandrill";
peppers  = imread('images/peppers.png');  peppers_name  = "peppers";

% pca on watermark
cameraman = imread('cameraman.png');
watermark = mypca(cameraman);

input = rgb2gray(barbara);
var   = start_function(input,watermark,barbara_name);
 
input = rgb2gray(lenna);
var1  = start_function(input,watermark,lenna_name);
 
input = rgb2gray(mandrill);
var2  = start_function(input,watermark,mandrill_name);
 
input = rgb2gray(peppers);
var3  = start_function(input,watermark,peppers_name);