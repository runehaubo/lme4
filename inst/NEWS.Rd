\newcommand{\PR}{\Sexpr[results=rd]{tools:::Rd_expr_PR(#1)}}

\name{NEWS}
\title{lme4 News}
\encoding{UTF-8}
\section{CHANGES IN VERSION 1.1-0}{
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item when using the default \code{method="profile"},
      \code{confint} now returns appropriate upper/lower bounds
      (-1/1 for correlations, 0/Inf for standard deviations)
      rather than \code{NA} when appropriate
    }
  }
}

\section{CHANGES IN VERSION 1.0-5 (2013-10-16)}{
  \subsection{USER-VISIBLE CHANGES}{
    \itemize{
      \item \code{confint.merMod} and \code{vcov.merMod} are
      now exported, for downstream package-author convenience
    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item eliminated redundant messages about suppressed
      fixed-effect correlation matrices when p>20
      \item most inverse-link functions are now bounded where
      appropriate by \code{.Machine$double.eps}, allowing fitting
      of GLMMs with extreme parameter values
      \item \code{merMod} objects created with \code{refit} did not
      work with \code{update}: optional
      \code{rename.response} option added to \code{refit.merMod}, to allow
      this (but the default is still \code{FALSE}, for
      back-compatibility (reported by A. Kuznetsova)
      \item fixed buglet preventing on-the-fly creation of index variables,
      e.g. \code{y~1+(1|rownames(data))} (reported by J. Dushoff)
    }
  }
}
\section{CHANGES IN VERSION 1.0-4 (2013-09-08)}{
  \subsection{BUG FIXES}{
    \itemize{
      \item \code{refit()} now works, again, with lists of
      length 1, so that e.g. \code{refit(.,simulate(.))} works.
      (Reported by Gustaf Granath)
      \item \code{getME(.,"ST")} was returning a list
      containing the Cholesky factorizations that get repeated in
      Lambda. But this was inconsistent with what \code{ST} represents in
      \code{lme4.0}. This inconsistency has now been fixed and
      \code{getME(.,"ST")} is now consistent with the definition of the
      \code{ST} matrix in \code{lme4.0}. See
      \code{https://github.com/lme4/lme4/issues/111} for more
      detail. Thanks to Vince Dorie.
      \item Corrected order of unpacking of standard
      deviation/correlation components, which affected results
      from \code{confint(.,method="boot")}. (Reported by Reinhold
      Kliegl)
      \item fixed a copying bug that made \code{refitML()}
      modify the original model
    }
  }
}

\section{CHANGES IN VERSION 1.0-1 (2013-08-17)}{
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item \code{check.numobs.*} and \code{check.numlev.*} in
      \code{(g)lmerControl} have been changed (from recent development
      versions) to \code{check.nobs.*} and
      \code{check.nlev.*} respectively, and the default values of
      \code{check.nlev.gtreq.5} and \code{check.nobs.vs.rankZ}
      have been changed to \code{"ignore"} and \code{"warningSmall"}
      respectively
      \item in \code{(g)lmerControl}, arguments to the optimizer
      should be passed as a list called \code{optCtrl}, rather than
      specified as additional (ungrouped) arguments
      \item the \code{postVar} argument to \code{ranef} has been
      changed to the (more sensible) \code{condVar} ("posterior variance"
      was a misnomer, "conditional variance" -- short for "variance of the
      conditional mode" -- is preferred)
      \item the \code{REform} argument to \code{predict} has been changed
      to \code{ReForm} for consistency
      \item the \code{tnames} function, briefly exported, has been
      unexported
      \item \code{getME(.,"cnms")} added
      \item \code{print} method for \code{merMod} objects is now more
      terse, and different from \code{summary.merMod}
      \item the \code{objective} method for the \code{respMod}
      reference class now takes an optional \code{sigma.sq} parameter
      (defaulting to \code{NULL}) to allow calculation of the
      objective function with a residual variance different from
      the profiled value (Vince Dorie)
    }
  }
}
\section{CHANGES IN VERSION 1.0-0 (2013-08-01)}{
  \subsection{MAJOR USER-VISIBLE CHANGES}{
    \itemize{
      \item Because the internal computational machinery has changed,
      results from the newest version of \code{lme4} will not be numerically
      identical to those from previous versions.  For reasonably well-
      defined fits, they will be extremely close (within numerical
      tolerances of 1e-4 or so), but for unstable or poorly-defined fits
      the results may change, and very unstable fits may fail when they
      (apparently) succeeded with previous versions. Similarly, some fits
      may be slower with the new version, although on average the new
      version should be faster and more stable. More numerical
      tuning options are now available (see below); non-default settings
      may restore the speed and/or ability to fit a particular model without
      an error. If you notice significant or disturbing changes when fitting
      a model with the new version of \code{lme4}, \emph{please notify the maintainers}.
      \item \code{VarCorr} returns its results in the same format as before (as a
      list of variance-covariance matrices with \code{correlation} and \code{stddev}
      attributes, plus a \code{sc} attribute giving the residual standard
      deviation/scale parameter when appropriate), but prints them in a
      different (nicer) way.
      \item By default \code{residuals} gives deviance (rather than Pearson)
      residuals when applied to \code{glmer} fits (a side effect of matching \code{glm}
      behaviour more closely).
      \item As another side effect of matching \code{\link{glm}}
      behaviour, reported log-likelihoods from \code{\link{glmer}} models
      are no longer consistent with those from pre-1.0 \code{lme4},
      but \emph{are} consistent with \code{glm}; see \code{\link{glmer}}
      examples.
    }
  }
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item More use is made of S3 rather than S4 classes and methods: one
      side effect is that the \code{nlme} and \code{lme4} packages are now much more
      compatible; methods such as \code{fixef} no longer conflict.
      \item The internal optimizer has changed. \code{[gn]lmer} now has an
      \code{optimizer} argument; \code{"Nelder_Mead"} is the default for \code{[n]lmer},
      while a combination of \code{"bobyqa"} (an alternative derivative-free
      method) and \code{"Nelder_Mead"} is the default for \code{glmer}. To use the
      \code{nlminb} optimizer as in the old version of \code{lme4}, you can use
      \code{optimizer="optimx"} with \code{control=list(method="nlminb")} (you will
      need the \code{optimx} package to be installed and loaded). See
      \code{\link{lmerControl}} for details.
      \item Families in GLMMs are no longer restricted to built-in/hard-
      coded families; any family described in \code{\link{family}}, or following that
      design, is usable (although there are some hard-coded families, which
      will be faster).
      \item \code{[gn]lmer} now produces objects of class \code{merMod} rather than
      class \code{mer} as before.
      \item the structure of the \code{Zt} (transposed random effect
      design matrix) as returned by \code{getME(.,"Zt")}, and the
      corresponding order of the random effects vector
      (\code{getME(.,"u")}) have changed. To retrieve \code{Zt}
      in the old format, use \code{do.call(Matrix::rBind,getME(.,"Ztlist"))}.
      \item the package checks input more thoroughly for
      non-identifiable or otherwise problematic cases: see
      \code{\link{lmerControl}} for fine control of the test behaviour.
    }
  }
  \subsection{NEW FEATURES}{
    \itemize{
      \item A general-purpose \code{\link{getME}} accessor method allows
      extraction of a wide variety of components of a mixed-model
      fit. \code{getME} also allows a vector of objects to be returned as
      a list of mixed-model componenets. This has been backported to
      be compatible with older versions of \code{lme4} that still produce \code{mer}
      objects rather than \code{merMod} objects. However, backporting is incomplete;
      some objects are only extractable in newer versions of \code{lme4}.
      \item Optimization information (convergence codes, warnings, etc.)
      is now stored in an \code{@optinfo} slot.
      \item \code{\link{bootMer}} provides a framework for obtaining parameter confidence
      intervals by parametric bootstrapping.
      \item \code{\link{plot.merMod}} provides diagnostic plotting
      methods similar to those from the \code{nlme} package
      (although missing \code{augPred}).
      \item A \code{\link{predict.merMod}} method gives predictions;
      it allows an effect-specific choice of conditional prediction or prediction at the
      population level (i.e., with random effects set to zero).
      \item Likelihood profiling for \code{lmer} and \code{glmer} results (see
      \code{link{profile-methods}}).
      \item Confidence intervals by likelihood profiling (default),
      parametric bootstrap, or Wald approximation (fixed effects only):
      see \code{\link{confint.merMod}}
      \item \code{nAGQ=0}, an option to do fast (but inaccurate) fitting of GLMMs.
      \item Using \code{devFunOnly=TRUE} allows the user to extract a deviance
      function for the model, allowing further diagnostics/customization of
      model results.
      \item The internal structure of [gn]lmer is now more modular, allowing
      finer control of the different steps of argument checking; construction
      of design matrices and data structures; parameter estimation; and construction
      of the final \code{merMod} object (see \code{?modular}).
      \item the \code{formula}, \code{model.frame}, and \code{terms}
      methods return full versions (including random effect terms and
      input variables) by default, but a \code{fixed.only} argument
      allows access to the fixed effect submodel.
    }
  }
  \subsection{EXPERIMENTAL FEATURES}{
    \itemize{
      \item \code{\link{glmer.nb}} provides an embryonic negative
      binomial fitting capability.
    }
  }
  \subsection{STILL NON-EXISTENT FEATURES}{
    \itemize{
      \item Adaptive Gaussian quadrature (AGQ) is not available for multiple and/or
      non-scalar random effects.
      \item Posterior variances of conditional models for non-scalar random effects.
      \item Standard errors for \code{\link{predict.merMod}} results.
      \item Automatic MCMC sampling based on the fit turns out to be very difficult
      to implement in a way that is really broadly reliable and robust; \code{mcmcsamp}
      will not be implemented in the near future. See
      \code{\link{pvalues}} for alternatives.
      \item "R-side" structures (within-block correlation and heteroscedasticity) are
      not on the current timetable.
    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item In a development version, prior weights were not being used properly in
      the calculation of the residual standard deviation, but this has been fixed.
      Thanks to Simon Wood for pointing this out.
      \item In a development version, the step-halving component of the penalized
      iteratively reweighted least squares algorithm was not working, but
      this is now fixed.
      \item In a development version, square \code{RZX} matrices would lead to a
      \code{pwrssUpdate did not converge in 30 iterations} error. This has been fixed
      by adding an extra column of zeros to \code{RZX}.
    }
  }
  \subsection{DEPRECATED AND DEFUNCT}{
    \itemize{
      \item Previous versions of \code{lme4} provided
      the \code{mcmcsamp} function, which efficiently generated
      a Markov chain Monte Carlo sample from the posterior
      distribution of the parameters, assuming flat (scaled
      likelihood) priors. Due to difficulty in constructing a
      version of \code{mcmcsamp} that was reliable even in
      cases where the estimated random effect variances were
      near zero (e.g.
      \url{https://stat.ethz.ch/pipermail/r-sig-mixed-models/2009q4/003115.html}),
      \code{mcmcsamp} has been withdrawn (or more precisely,
      not updated to work with \code{lme4} versions >=1.0).
      \item Calling \code{glmer} with the default \code{gaussian} family
      redirects to \code{lmer}, but this is deprecated
      (in the future \code{glmer(...,family="gaussian")} may
      fit a LMM using the penalized iteratively reweighted least squares
      algorithm). Please call \code{lmer} directly.
      \item Calling \code{lmer} with a \code{family} argument redirects
      to \code{glmer}; this is deprecated. Please call \code{glmer} directly.
    }
  }
}
\section{CHANGES IN VERSION 0.999375-16 (2008-06-23)}{
  \subsection{MAJOR USER-VISIBLE CHANGES}{
    \itemize{
       \item The underlying algorithms and representations for all the
       mixed-effects models fit by this package have changed - for
       the better, we hope. The class "mer" is a common
       mixed-effects model representation for linear, generalized
       linear, nonlinear and generalized nonlinear mixed-effects
       models.
       \item ECME iterations are no longer used at all, nor are analytic
       gradients. Components named 'niterEM', 'EMverbose', or
       'gradient' can be included in the 'control' argument to
       lmer(), glmer() or nlmer() but have no effect.
       \item PQL iterations are no longer used in glmer() and nlmer().
       Only the Laplace approximation is currently available. AGQ,
       for certain classes of GLMMs or NLMMs, is being added.
       \item The 'method' argument to lmer(), glmer() or nlmer() is
       deprecated. Use the 'REML = FALSE' in lmer() to obtain ML
       estimates. Selection of AGQ in glmer() and nlmer() will be
       controlled by the argument 'nAGQ', when completed.
    }
  }
  \subsection{NEW FEATURES}{
    \itemize{
      \item The representation of mixed-effects models has been
      dramatically changed to allow for smooth evaluation of the
      objective as the variance-covariance matrices for the random
      effects approach singularity. Beta testers found this
      representation to be more robust and usually faster than
      previous versions of lme4.
      \item The mcmcsamp function uses a new sampling method for the
      variance-covariance parameters that allows recovery from
      singularity. The update is not based on a sample from the
      Wishart distribution. It uses a redundant parameter
      representation and a linear least squares update.
      \item CAUTION: Currently the results from mcmcsamp look peculiar and
      are probably incorrect. I hope it is just a matter of my
      omitting a scaling factor but I have seen patterns such as
      the parameter estimate for some variance-covariance parameters
      being the maximum value in the chain, which is highly
      unlikely.
      \item The 'verbose' argument to lmer(), glmer() and nlmer() can be
      used instead of 'control = list(msVerbose = TRUE)'.
    }
  }
}
