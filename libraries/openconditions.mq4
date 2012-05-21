#include "base.mqh"
#include "type.mqh"
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
	if (OrderProfit() > min_profit)
	{
		if (DEBUG > 0)
		{
			Print("**!** open condition LastOrderHasProfit: profit ", OrderProfit(), " op ", op, " cnt ", cnt, " open price ", OrderOpenPrice(), " /true/");
		}

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
	if (MathAbs(OrderOpenPrice()-price) > slippage_p*VPOINT)
	{
		return (true);	
	}
	return (false);
}
