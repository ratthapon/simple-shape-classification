%% shape classification
% this script demostrate the simple shape classification framework using Jaccard index.
% Limited:
% 	cannot classify rotated shape (such as  rotated rectangle, trigangle)
% how to evaluate HMMs using Viterbi algorithm
%
% input format
%   model - cell array of simple images
%   test - the unknow shape
%   (n x m pixel binary image for test image and model images)
% 
% Rattaphon Hokking(rathapon_h@outlook.com) 5/5/2016
% 
% by Rattaphon H.
test = []; % the unknow shape
load('shapeModel.mat'); % load shapes database
load('test'); % load the unknow shape, we call 'test' data
label = [{'triangle'}, {'circle'}, {'rectangle'}]; % define shape label
similarityValue = zeros(3,1); % allocate similarity matrix
cmpAtSize = [50 50];

classTest = 0; % you don't know the class of test data
for shapeIdx = 1:size(model, 1)
    shape = model{shapeIdx}; % get shape from database
    
    % normalize size
    shape = imresize(shape, cmpAtSize);
    test = imresize(test, cmpAtSize);
    
    % compare the test pic by model pic
    inters = test & shape; % intersection
    uni = test | shape; % union
    similarityValue(shapeIdx,1) = sum(inters(:)) / sum(uni(:)); % compute Jaccard similarity
    
end
% find the most similarity value
[~, classTest] = max(similarityValue);
label{classTest} % map to label and show it.
