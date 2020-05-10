fuzzy_beer = readfis("fuzzy_beer")

beer_data = [
    0.57    4.45    4.69    0.54;
    0.56    4.45    4.70    0.50;
    0.57    4.42    5.03    0.41;
    0.57    4.43    4.97    0.43;
    0.58    4.42    5.00    0.40;
    0.56    4.50    5.62    0.24;
];

evalfis(fuzzy_beer, beer_data)