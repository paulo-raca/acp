fis = readfis("beer.fis");
testdata = [
    0.57 4.45 4.69 0.54;
    0.56 4.45 4.7 0.5;
    0.57 4.42 5.03 0.41;
    0.57 4.43 4.97 0.43;
    0.58 4.42 5 0.4;
    0.56 4.5 5.62 0.24;
];
test_results = evalfis(fis, testdata)