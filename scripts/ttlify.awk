#!/usr/bin/awk -f

BEGIN {
	FS = "|";
	OFS = "\t";
	print "@prefix foaf: <http://xmlns.com/foaf/0.1/> .";
	print "@prefix bsym: <http://bsym.bloomberg.com/sym/> .";
	print "@prefix bps: <http://bsym.bloomberg.com/pricing_source/> .";
	print "@prefix figi-gii: <http://www.omg.org/spec/FIGI/GlobalInstrumentIdentifiers/> .";
	print "@prefix gas: <http://schema.ga-group.nl/symbology#> .";
	print;

	mstbl["Comdty"] = "CommodityMarketSector";
	mstbl["Corp"] = "CorporateBondMarketSector";
	mstbl["Curncy"] = "CurrencyMarketSector";
	mstbl["Equity"] = "EquityMarketSector";
	mstbl["Govt"] = "GovernmentBondMarketSector";
	mstbl["Index"] = "IndexFundMarketSector";
	mstbl["M-Mkt"] = "MoneyMarketFundMarketSector";
	mstbl["Mtge"] = "MortgageMarketSector";
	mstbl["Muni"] = "MunicipalBondMarketSector";
	mstbl["Pfd"] = "PreferredStockMarketSector";
}
(NR > 1 && $8 != $9) {
	print "bsym:" $8, "a", "figi-gii:GlobalIdentifier ;";
	print "", "gas:sector", "figi-gii:" mstbl[$7] " ;";
	gsub(/"/, "\\\"", $1);
	print "", "foaf:name", "\"" $1 "\" ;";
	print "", "gas:listedOn", "bps:" $3 " ;";
	print "", "gas:listedAs", "\"" $2 "\" .";
}
($8 == $9) {
	print "bsym:" $9, "a", "figi-gii:CompositeGlobalIdentifier .";
}
