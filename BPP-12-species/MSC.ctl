          seed =  -1

       seqfile = all-sp-input.phy
      Imapfile = all-sp-map.txt
       outfile = out.b1.txt
      mcmcfile = mcmc.b1.txt

  speciesdelimitation = 0 * fixed species tree
* speciesdelimitation = 1 0 2    * species delimitation rjMCMC algorithm0 and finetune(e)
* speciesdelimitation = 1 1 2 1 * species delimitation rjMCMC algorithm1 finetune (a m)
*         speciestree = 1 0.1 0.1 0.2    * species tree SPR/SNL

*   speciesmodelprior = 1  * 0: uniform LH; 1:uniform rooted trees; 2: uniformSLH; 3: uniformSRooted

  species&tree = 12  Cca Cda Chu Cto Cpo Ckw Asi Caq Cil Cco Cov Cla
               	     1 1 1 1 1 1 1 1 1 1 1 1
	((((((Cca,Cda)a,Chu)b,Cto)c,(Cpo,Ckw)d)e,Asi)f,((Caq,Cil)g,((Cov,Cla)h,Cco)i)j)k;
	phase = 1 1 1 1 1 1 1 1 1 1 1 1
       usedata = 1  * 0: no data (prior); 1:seq like
         nloci = 773 * number of data sets in seqfile

     cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

    thetaprior = 3 0.002 e  # Inv-gamma(a, b) for theta (integrated out by default; add E to also sample theta)
      tauprior = 3 0.02     # Inv-gamma(a, b) for root tau
*   thetaprior = gamma 2 100  # gamma(a, b) for theta
*    tauprior = gamma 2 10   # gamma(a, b) for root tau
    phiprior = 1 1  # Beta(a, b) for root tau & Dirichlet(a) for other tau's

      finetune =  1: 3 0.003 0.002 0.00002 0.005 0.9 0.001 0.001 # finetune for GBtj, GBspr, theta, tau, mix

         print = 1 0 0 0   * MCMC samples, locusrate, heredityscalars, Genetrees
        burnin = 500000
      sampfreq = 200
       nsample = 10000
      Threads = 20 169 1
