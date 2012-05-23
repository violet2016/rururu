#property library
#include "base.mqh"
#include "type.mqh"
#include "closeconditions.mqh"
void CloseAllMagic(int magic)
{
	int cnt = 0;
	double close_price;
	color close_color;
	while (CurrentOrderNumberMagic(magic) > 0)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderMagicNumber()==magic)
		{
			close_price = GetClosePrice(OrderType());
			close_color = GetCloseColor(OrderType());
			OrderClose(OrderTicket(), OrderLots(), close_price, SLIPPAGE, close_color);	
		}
		else
		{
			cnt++;
		}
	}
	return;
}

void TypeCloseAllMagic(int op, int magic)
{
	int cnt = 0;
	double close_price = GetClosePrice(op);
	color close_color = GetCloseColor(op);
	while (TypeCurrentOrderNumberMagic(op, magic) > 0)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderType()==op && OrderMagicNumber()==magic)
		{
			OrderClose(OrderTicket(), OrderLots(), close_price, SLIPPAGE, close_color);	
		}
		else
		{
			cnt++;
		}
	}
	return;

}

double GetTrailingStopPrice(int op, double open_price, double percent)
{
	double res;
	double close_price = GetClosePrice(op);
	if (op == OP_SELL)
	{
		res = open_price - (open_price-close_price)*percent;
	}
	else
	{
		res = open_price + (close_price-open_price)*percent;
	}
	return (res);
}

void CloseWithTrailingStop(double profit, double percent, int magic)
{
	int cnt = 0;
	for (; cnt < OrdersTotal(); cnt++)
	{
		if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)==false)
		{
			break;
		}
		if (OrderMagicNumber()!=magic)
		{
			continue;
		}
		if (OrderProfit()*percent > profit)
		{
			double price = GetTrailingStopPrice(OrderType(), OrderOpenPrice(), percent);
			color mcolor = GetModifyColor(OrderType());
			if (!OrderModify(OrderTicket(), OrderOpenPrice(), price, OrderTakeProfit(), 0, mcolor))
			{
				Print(GetLastError());
			}
		}
	
	}
	
}

void CloseAllWithTotalProfit(double total_profit, int magic)
{
	if (TotalProfitLargerThan(total_profit, magic))
	{
		CloseAllMagic(magic);	
	}

}

int Fibonacci(int number)
{
	if (number <= 0)
	{
		return (0);
	}
	if (number == 1)
	{
		return (1);	
	}
	return (Fibonacci(number-1) + Fibonacci(number-2));
}

int CalculateSlotFibonacci(int op, int base, int magic)
{
	int number = TypeCurrentOrderNumberMagic(op, magic);
	int res = Fibonacci(number)*base;	
	return (res);
}

int CalculateSlotUniform(int op, int base, int magic)
{
	return (base);
}
