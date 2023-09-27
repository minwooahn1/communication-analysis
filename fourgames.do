*Import dataset "xxxdata.xlsx"
summarize
*decriptive stats for DV and IVs
hist Coop_standardized, freq
hist Coop_standardized, freq by(Game)
**3 sentiment scores
hist Bing, freq
hist Bing, by (Game)
*converting sentiment string variables into numeric values
encode Sentiment, generate(Sentiment2)
hist Sentiment2, freq discrete xlabel(1(2)3)
hist Sentiment2, discrete fraction
hist Sentiment2, freq discrete by (Game) xlabel(1(2)3)
**drop some GG games that don't have chat.
drop in 1224/1273
hist Vader
hist Vader, by (Game)
hist Stock2
**zeros: either neutral or no chat
*control varaibles: male, game type, # words, gini_words, variability limited visibility, stock
*h1: overall cooperation ~ positive sentiment
*check stock variable
reg Coop_standardized words_num Gini_chat, vce (cluster Group)
reg Coop_standardized Bing words_num Gini_chat, vce (cluster Group)
eststo Bing
reg Coop_standardized Sentiment2 words_num Gini_chat, vce (cluster Group)
eststo Polarity
reg Coop_standardized Vader words_num Gini_chat, vce (cluster Group)
eststo Vader
coefplot Bing Vader Polarity, drop(_cons) xtitle (Cooperation) order(Vader Bing Sentiment2) xline(0, lcolor(black) lwidth(thin) lpattern(dash))
xsize(5.5) ysize(3.8)
**with more controls, but losing important observations
reg Coop_standardized Male_percent words_num Gini_words Stock2 Variability, vce (cluster Group)
reg Coop_standardized Bing words_num Gini_chat Stock Variability LimitedVisibility Male_percent, vce (cluster Group)
eststo Bing
reg Coop_standardized Sentiment2 words_num Gini_chat Stock Variability LimitedVisibility Male_percent, vce (cluster Group)
eststo Polariy
reg Coop_standardized Vader words_num Gini_chat Stock Variability LimitedVisibility Male_percent, vce (cluster Group)
eststo Vader
coefplot Bing Vader Polarity, drop(_cons) xtitle (Cooperation) order(Vader Bing Sentiment2) xline(0, lcolor(black) lwidth(thin) lpattern(dash)) xsize(5.5) ysize(3.8)
*h2: different types of games
*gender info non existing
*foraging game
keep if FOR == 1
reg Coop_standardized Bing words_num Gini_chat if FOR==1, vce (cluster Group)
eststo Bing
reg Coop_standardized Vader words_num Gini_chat if FOR==1, vce (cluster Group)
eststo Vader
reg Coop_standardized Sentiment2 words_num Gini_chat if FOR==1, vce (cluster Group)
eststo Polarity
coefplot Bing Vader Polarity, drop(_cons) xtitle (Cooperation) order(Vader Bing Sentiment2) xline(0, lcolor(black) lwidth(thin) lpattern(dash))
xsize(5.5) ysize(3.8)
*Irrigation game
reg Coop_standardized Bing words_num Gini_words Stock Variability Male_percent LimitedVisibility if IRR==1, vce (cluster Group)
eststo Bing
reg Coop_standardized Sentiment2 words_num Gini_words Stock Variability Male_percent LimitedVisibility if IRR==1, vce (cluster Group)
eststo Polarity
reg Coop_standardized Vader words_num Gini_words Stock Variability Male_percent LimitedVisibility if IRR==1, vce (cluster Group)
eststo Vader
coefplot Bing Vader Polarity, drop(_cons) xtitle (Cooperation) order(Vader Bing Sentiment2) xline(0, lcolor(black) lwidth(thin) lpattern(dash))
xsize(5.5) ysize(3.8)
*Groundwater
reg Coop_standardized Bing Gini_chat words_num Stock Male_percent if GG==1, vce(cluster Group)
eststo Bing
reg Coop_standardized Sentiment2 Gini_chat words_num  Stock Male_percent if GG==1, vce (cluster Group)
eststo Polarity
reg Coop_standardized Vader Gini_chat words_num Stock Male_percent if GG==1,vce (cluster Group)
eststo Vader
coefplot Bing Vader Polarity, drop(_cons) xtitle (Cooperation) order(Vader Bing Sentiment2) xline(0, lcolor(black) lwidth(thin) lpattern(dash))
xsize(5.5) ysize(3.8)
*port of mars
reg Coop_standardized Bing words_num Gini_words Stock Male_percent if POM==1, vce(cluster Group)
eststo Bing
reg Coop_standardized Sentiment2 words_num Gini_words Stock Male_percent if POM==1, vce (cluster Group)
eststo Polarity
reg Coop_standardized Vader words_num Gini_words Stock Male_percent if POM==1,vce (cluster Group)
eststo Vader
coefplot Bing Vader Polarity, drop(_cons) xtitle (Cooperation) order(Vader Bing Sentiment2) xline(0, lcolor(black) lwidth(thin) lpattern(dash))
xsize(5.5) ysize(3.8)
