#import "openconditions.ex4"

bool IsOnGrid(int op, double grid, double offset);
bool IsNewOpenPrice(int op, int slippage_p, int magic);
bool LastOrderHasProfit(int op, double min_profit, int magic);
bool IsNewOpenPriceToLastOrder(int op, int slippage_p, int magic);
