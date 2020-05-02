%load("practice_data", "data");
load("fabric_data", "data");

% Train neural network
net = perceptron
net.trainParam.showWindow = false;
net = train(net, data.train.in', data.train.out');

% Evaluate test
test_out = sim(net, data.test.in')
if ~isfield(data.test, 'out') 
    data.test.out = test_out;
end

% Plot train data and threshold line
figure(1)
plotpv(data.train.in', data.train.out');
plotpc(net.IW{1}, net.b{1});

% Plot test data and threshold line
figure(2)
plotpv(data.test.in', data.test.out');
plotpc(net.IW{1}, net.b{1});
