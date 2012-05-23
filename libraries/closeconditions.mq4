#include "base.mqh"
#property library

bool TotalProfitLargerThan(double profit, int magic)
{
	if (GetTotalProfit(magic) > profit)
	{
		return (true);
	}
	return (false);
}

bool TypeTotalProfitLargerThan(int op, double profit, int magic)
{
	if (TypeGetTotalProfit(op, magic) > profit)
	{
		return (true);
	}
	return (false);
}

bool ProfitLargerThan(double profit)
{
	if (OrderProfit() > profit)
	{
		return (true);
	}
	else
	{
		return (false);
	}
}
