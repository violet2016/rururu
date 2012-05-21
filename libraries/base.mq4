#include "type.mqh"
#property library

#define CLOSE_COLOR_BUY Red
#define	OPEN_COLOR_BUY HotPink
#define CLOSE_COLOR_SELL Blue
#define OPEN_COLOR_SELL RoyalBlue

double GetOpenPrice(int op)
{
	if (op == OP_SELL)
	{
		return (Bid);
	}
	else if (op == OP_BUY)
	{
		return (Ask);
	}
	return (0.0);
}

double GetClosePrice(int op)
{
	if (op == OP_SELL)
	{
		return (Ask);
	}
	else if (op == OP_BUY)
	{
		return (Bid);
	}
	return (0.0);
}

color GetOpenColor(int op)
{
	if (op == OP_SELL)
	{
		return (OPEN_COLOR_SELL);
	}
	else if (op == OP_BUY)
	{
		return (OPEN_COLOR_BUY);
	}
	return (Black);
}

color GetCloseColor(int op)
{
	if (op == OP_SELL)
	{
		return (CLOSE_COLOR_SELL);
	}
	else if (op == OP_BUY)
	{
		return (CLOSE_COLOR_BUY);
	}
	return (Black);
}

double TypeGetTotalProfit(int op, int magic)
{
	double res = 0.0;
	int cnt = 0;
	for (; cnt < OrdersTotal(); cnt++)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderType()==op && OrderMagicNumber()==magic)
		{
			res += OrderProfit();
		}
	}
	return (res);
}

double GetTotalProfit(int magic)
{
	double res = 0.0;
	int cnt = 0;
	for (; cnt < OrdersTotal(); cnt++)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderMagicNumber()==magic)
		{
			res += OrderProfit();
		}
	}
	return (res);
}

int SelectLastOrder(int magic)
{
	int cnt = OrdersTotal() - 1;
	for (; cnt >= 0; cnt--)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			continue;
		}
		if (OrderMagicNumber()==magic)
		{
			return (cnt);
		}
	}
	return (cnt);
}

int TypeSelectLastOrder(int op, int magic)
{
	int cnt = OrdersTotal() - 1;
	for (; cnt >= 0; cnt--)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			continue;
		}
		if (OrderType()==op && OrderMagicNumber()==magic)
		{
			return (cnt);
		}
	}
	return (cnt);
}

int TypeCurrentOrderNumberMagic(int op, int magic)
{
	int cnt = 0;
	int res = 0;
	for (; cnt < OrdersTotal(); cnt++)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderType()==op && OrderMagicNumber()==magic)
		{
			res++;
		}
	}
	return (res);
}

int CurrentOrderNumberMagic(int magic)
{
	int cnt = 0;
	int res = 0;
	for (; cnt < OrdersTotal(); cnt++)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderMagicNumber()==magic)
		{
			res++;
		}
	}
	return (res);

}

double OrderHighestPriceMagic(int op, int magic)
{
	int cnt = 0;
	double res = 0;
	for (; cnt < OrdersTotal(); cnt++)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderType()==op && OrderMagicNumber()==magic)
		{
			if (OrderOpenPrice() > res)
			{
				res = OrderOpenPrice();
			}
		}
	}
	return (res);
}

double OrderLowestPriceMagic(int op, int magic)
{
	int cnt = 0;
	double res = MAXINT;
	for (; cnt < OrdersTotal(); cnt++)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderType()==op && OrderMagicNumber()==magic)
		{
			if (OrderOpenPrice() < res)
			{
				res = OrderOpenPrice();
			}
		}
	}
	return (res);
}
