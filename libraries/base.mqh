#import "base.ex4"

double GetOpenPrice(int op);
double GetClosePrice(int op);
color GetOpenColor(int op);
color GetCloseColor(int op);

double TypeGetTotalProfit(int op, int magic);
double GetTotalProfit(int magic);

int SelectLastOrder(int magic);
int TypeSelectLastOrder(int op, int magic);

int CurrentOrderNumberMagic(int magic);
int TypeCurrentOrderNumberMagic(int op, int magic);

double OrderLowestPriceMagic(int op, int magic);
double OrderHighestPriceMagic(int op, int magic);
