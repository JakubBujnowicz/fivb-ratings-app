calc_fivb_ratings <- function(t1, t2, k, cutoffs, scores,
                              sigma = 8,
                              scaling = 1e3,
                              digits = 2)
{
    cn <- c(0, cutoffs)
    cn <- sort(union(cn, -cn))
    cn <- c(-Inf, cn, Inf)

    delta <- sigma / scaling * (t1 - t2)
    cdelta <- cn + delta
    probs <- diff(pnorm(cdelta))

    e <- sum(scores * probs)
    f <- k / sigma

    cap <- 10^(-digits)

    rslt <- data.table(Result = names(scores),
                       Score = scores)
    rslt[, Change := f * (Score - e)]
    rslt[, FinalChange := fifelse(Score > 0,
                                  pmax(Change, cap),
                                  pmin(Change, -cap))]
    rslt[, `:=`(NewT1 = t1 + FinalChange,
                NewT2 = t2 - FinalChange)]

    rslt
}

