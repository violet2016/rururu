#property library
#include "base.mqh"
#include "type.mqh"

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
