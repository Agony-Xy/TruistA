/*
Truiast Project Univariate Analysis
*/

*Set filerefs and librefs using relative paths;
x "cd S:\";
libname input_data "project_data";

filename acqu "project_data/Acquisition_data";
filename perf "project_data/Performance_data";

*Input acquisition data;
data work.acqu2006q1;
  infile acqu("Acquisition_2006Q1.txt") dsd dlm="|" firstobs=4;
  input lid $ ochannel $ name $ oir oupb oterm od $ fpd $ oltv ocltv nob odti ocs 
        fthbi $ lp $ pt $ nou $ ot $ ps $ zip $ pmip ptt $ ccs mit rmi $;
run;
data work.acqu2006q2;
  infile acqu("Acquisition_2006Q2.txt") dsd dlm="|" firstobs=4;
  input lid $ ochannel $ name $ oir oupb oterm od $ fpd $ oltv ocltv nob odti ocs 
        fthbi $ lp $ pt $ nou $ ot $ ps $ zip $ pmip ptt $ ccs mit rmi $;
run;

*Merge all data together;
data work.acqu;
  set work.acqu2006q1 work.acqu2006q2;
run;

*Univariate analysis;
proc means data=work.acqu;
  label oir="original interest rate"
        oupb="original UPB"
        oterm="original term"
        oltv="original LTV"
        ocltv="original combined LTV"
        nob="number of borrowers"
        odti="original debt to income"
        ocs="original credit score"
        pmip="primary mortgage insurance percent"
        ccs="co-borrower credit score"
        mit="mortgage insurance type"
        ;
run;


*Input performance data;
data work.perf2006q1;
  infile perf("Performance_2006Q1.txt") dsd dlm="|" firstobs=4;
  input lid $ mrp $ name $ cir cupb la rmtlm amtm md $ msa $ clds $ mf $ zbc $ 
        zbed $ lpid $ fd $ dd $ fc pparc arc mheac atfhp nsp cep pmwp ofp nibubp 
        pfa rmwpf $ fpwa $ sai $;
run;
data work.perf2006q2;
  infile perf("Performance_2006Q2.txt") dsd dlm="|" firstobs=4;
  input lid $ mrp $ name $ cir cupb la rmtlm amtm md $ msa $ clds $ mf $ zbc $ 
        zbed $ lpid $ fd $ dd $ fc pparc arc mheac atfhp nsp cep rmwp ofp nibubp 
        pfa rmwpf $ fpwa $ sai $;
run;

*Merge all data together;
data work.perf;
  set work.perf2006q1 work.perf2006q1;
run;

*Univariate analysis;
proc means data=work.perf;
  label cir="current interest rate"
        cupb="current UBP"
        la="loan age"
        rmtlm="remaining months to legal maturity"
        amtm="adjusted months to maturity"
        fc="foreclosure costs"
        pparc="property preservation and repair costs"
        arc="asset recovery costs"
        mheac="miscellaneous holding expenses and credits"
        atfhp="associated taxes for holding property"
        nsp="net sale proceeds"
        cep="credit enhencement proceeds"
        rmwp="repurchase make whole proceeds"
        ofp="other foreclosure proceeds"
        nibubp="non interest bearing UPB"
        pfa="prinpal forgiveness amount"
run;
