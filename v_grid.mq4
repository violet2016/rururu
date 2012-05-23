#include "libraries/base.mqh"
#include "libraries/type.mqh"
#include "libraries/openclose.mqh"
#include "libraries/openconditions.mqh"
#include "libraries/closeconditions.mqh"
#include "v_grid_config.mqh"
#property copyright "Violet"

double grid = 0.0;
int slippage = 3;

int init()
{
	grid = GRID_POINT*VPOINT;
	return (0);
}

bool CheckAndOpen(int op, int magic)
{
	if (
		IsOnGrid(op, grid, 0.0) &&
		IsNewOpenPrice(op, slippage, magic) &&
		LastOrderHasProfit(op, slippage, magic)
	)
	{
		double o_price = GetOpenPrice(op);
		color o_color = GetOpenColor(op);
		double stoploss = 0;
		double takeprofit = 0;
		OrderSend(Symbol(), op, LOTS, o_price, slippage, stoploss, takeprofit, "", magic, 0, o_color);
	}
}

void CheckAndClose(int magic)
{
//	CloseAllWithTotalProfit(TOTAL_PROFIT, magic);
	CloseWithTrailingStop(PROFIT_POINT, MOVETS_PERCENT, magic);
}

int start()
{
	if (!START)
	{
		return (0);
	}
	CheckAndOpen(OP_SELL, MAGIC);
	CheckAndOpen(OP_BUY, MAGIC);
	CheckAndClose(MAGIC);
	return (0);
}
