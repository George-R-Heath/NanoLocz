


img = Part.Image(:,:,Part.IncludeImages);
[optimizer,metric] = imregconfig("multimodal");
 optimizer.InitialRadius = 0.009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 300;
for i = 1:numel(img(1,1,:))
aligned(:,:,i) = imregister(img(:,:,i),ref.image,"affine",optimizer,metric);
end