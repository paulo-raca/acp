load("estufa.mat", "data");
%load("emissions", "data");

[train_in_norm, normalization.train.in] = mapminmax(data.train.in');
[train_out_norm, normalization.train.out] = mapminmax(data.train.out');

% I used the same normalization parameteres for train and test,
% In contrast with professor video, which normalized them independently.

% Code to normalize test dataset independently
[test_in_norm, normalization.test.in] = mapminmax(data.test.in');
[test_out_norm, normalization.test.out] = mapminmax(data.test.out');

% Code to normalize test dataset with the same transformation
%normalization.test.in = normalization.train.in;
%normalization.test.out = normalization.train.out;
%test_in_norm = mapminmax("apply", data.test.in', normalization.train.in);
%test_out_norm = mapminmax("apply", data.test.out', normalization.train.out);

net = feedforwardnet(10, 'trainlm');
net.trainParam.showWindow = false;
net = train(net, train_in_norm, train_out_norm);

train_pred_norm = sim(net, train_in_norm);
data.train.pred = mapminmax("reverse", train_pred_norm, normalization.train.out)';
data.train.perf = perform(net, train_pred_norm, train_out_norm);

figure(1);;
subplot(221);
plot(data.train.pred, '-b');
hold on;
plot(data.train.out, 'or');
xlabel("Data vector (train)");
ylabel("Output");
hold off;


test_pred_norm = sim(net, test_in_norm);
data.test.pred = mapminmax("reverse", test_pred_norm, normalization.test.out)';
data.test.perf = perform(net, test_pred_norm, test_out_norm);

%figure(2);
subplot(222);
plot(data.test.pred, '-b');
hold on;
plot(data.test.out, 'or');
xlabel("Data vector");
ylabel("Output (test)");
hold off;

%figure(3);
subplot(223);
plot(data.train.in, data.train.out, 'or');
hold on;
eval.train.in = linspace(min(data.train.in), max(data.train.in));
eval.train.in_norm = mapminmax("apply", eval.train.in, normalization.train.in);
eval.train.pred_norm = sim(net, eval.train.in_norm);
eval.train.pred = mapminmax("reverse", eval.train.pred_norm, normalization.train.out);
plot(eval.train.in, eval.train.pred, '-b');
xlabel("Input (train)");
ylabel("Output");
hold off;

%figure(4);
subplot(224);
plot(data.test.in, data.test.out, 'or');
hold on;
eval.test.in = linspace(min(data.test.in), max(data.test.in));
eval.test.in_norm = mapminmax("apply", eval.test.in, normalization.test.in);
eval.test.pred_norm = sim(net, eval.test.in_norm);
eval.test.pred = mapminmax("reverse", eval.test.pred_norm, normalization.test.out);
plot(data.test.in, data.test.pred, '-b');
xlabel("Input (test)");
ylabel("Output");
hold off;

data.train.perf
data.test.perf
