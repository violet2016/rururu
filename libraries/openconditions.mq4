#include "base.mqh"
#include "type.mqh"
#include "openclose.mqh"
#property library

#define DEBUG 0 

bool IsOnGrid(int op, double grid, double offset)
{
	double price = GetOpenPrice(op);
	double res = MathMod(price-offset, grid);
	/*
	if (DEBUG > 0)
	{
		Print("**!** open condition IsOnGrid: remainder ", res, ", price ", price, " grid ", grid);
	}
	*/
	if (res < VPOINT*SLIPPAGE)
	{
		return (true);
	}
	else
	{
		return (false);
	}
}

bool IsNewOpenPrice(int op, int slippage_p, int magic)
{
	double price = GetOpenPrice(op);
	int cnt = 0;
	for (; cnt < OrdersTotal(); cnt++)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderType()==op && OrderMagicNumber()==magic)
		{
			if (MathAbs(OrderOpenPrice()-price) <= slippage_p*VPOINT)
			{
				/*
				if (DEBUG > 0)
				{
					Print("**!** open condition IsNewOpenPrice: Order ", cnt, " price ", OrderOpenPrice(), " /false/");
				}
				*/
				return (false);
			}
		}
	}
	return (true);
}

bool LastOrderHasProfit(int op, double min_profit, int magic)
{
	int cnt = TypeSelectLastOrder(op, magic);
	//No last order
	if (cnt < 0)
	{
		/*
		if (DEBUG > 0)
		{
			Print("**!** open condition LastOrderHasProfit: No last order. /true/");
		}
		*/
		return (true);
	}
	if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES) == false)
		return (false);
	
	if (OrderProfit() > min_profit)
	{
		/*
		if (DEBUG > 0)
		{
			double price = GetClosePrice(op);
			Print("**!** open condition LastOrderHasProfit: profit ", OrderProfit(), " cnt ", cnt, " open price ", OrderOpenPrice(), " close price ", price, " /true/");
		}
		*/
		return (true);
	}
	return (false);
}

bool IsNewOpenPriceToLastOrder(int op, int slippage_p, int magic)
{
	double price = GetOpenPrice(op);
	int cnt = SelectLastOrder(magic);
	if (cnt < 0)
	{
		return (true);
	}
	if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES) == false)
		return (false);
	if (MathAbs(OrderOpenPrice()-price) > slippage_p*VPOINT)
	{
		return (true);	
	}
	return (false);
}

bool IsOnSlotFibonacci(int op, int base, int magic)
{
	int slot_p = CalculateSlotFibonacci(op, base, magic);
	int cnt = TypeSelectLastOrder(op, magic);
	if (cnt < 0)
	{
		return (true);
	}
	double price = GetOpenPrice(op);
	OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
	if (MathAbs(OrderOpenPrice()-price)>slot_p*VPOINT && OrderProfit()>SLIPPAGE)
	{
		return (true);
	}
	return (false);
}
