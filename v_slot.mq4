#include "libraries/base.mqh"
#include "libraries/type.mqh"
#include "libraries/openclose.mqh"
#include "libraries/openconditions.mqh"
#include "libraries/closeconditions.mqh"
#include "v_slot_config.mqh"
#property copyright "Violet"

int slippage = 3;

int init()
{
	return (0);
}

bool CheckAndOpen(int op, int magic)
{
	if (
		IsOnSlotFibonacci(op, BASE_SLOT_POINT, magic) &&
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
	CloseAllWithTotalProfit(TOTAL_PROFIT, magic);
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