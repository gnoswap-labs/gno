# GnoSwap Performance Summary Report

> Generated: 2026-01-21 19:11:19

## Overview

- **Total Commits**: 14
- **First Commit (Oldest)**: [`e5d1e16`](https://github.com/gnoswap-labs/gnoswap/tree/e5d1e16) - Base
- **Last Commit (Latest)**: [`2b031c5`](https://github.com/gnoswap-labs/gnoswap/tree/2b031c5) - Finalize Optimization

---

## Commit History

| # | Commit | Description | Report | Diff from Previous | Diff from Base |
|---|--------|-------------|--------|-------------------|----------------|
| 1 | [`e5d1e16`](https://github.com/gnoswap-labs/gnoswap/tree/e5d1e16) | Base | [📊 Report](reports/metric/commits/e5d1e16.md) | _Baseline_ | _Baseline_ |
| 2 | [`9dbd892`](https://github.com/gnoswap-labs/gnoswap/tree/9dbd892) | Optimize Uint256 | [📊 Report](reports/metric/commits/9dbd892.md) | [📈 Diff](reports/metric/compares/diff_9dbd892_e5d1e16.md) | [📊 Diff](reports/metric/compares/diff_9dbd892_e5d1e16.md) |
| 3 | [`31d883d`](https://github.com/gnoswap-labs/gnoswap/tree/31d883d) | Optimize Int256 | [📊 Report](reports/metric/commits/31d883d.md) | [📈 Diff](reports/metric/compares/diff_31d883d_9dbd892.md) | [📊 Diff](reports/metric/compares/diff_31d883d_e5d1e16.md) |
| 4 | [`94d4672`](https://github.com/gnoswap-labs/gnoswap/tree/94d4672) | Optimize Common | [📊 Report](reports/metric/commits/94d4672.md) | [📈 Diff](reports/metric/compares/diff_94d4672_31d883d.md) | [📊 Diff](reports/metric/compares/diff_94d4672_e5d1e16.md) |
| 5 | [`f468996`](https://github.com/gnoswap-labs/gnoswap/tree/f468996) | Optimize Pool | [📊 Report](reports/metric/commits/f468996.md) | [📈 Diff](reports/metric/compares/diff_f468996_94d4672.md) | [📊 Diff](reports/metric/compares/diff_f468996_e5d1e16.md) |
| 6 | [`51813f5`](https://github.com/gnoswap-labs/gnoswap/tree/51813f5) | Make pool use AVL tree | [📊 Report](reports/metric/commits/51813f5.md) | [📈 Diff](reports/metric/compares/diff_51813f5_f468996.md) | [📊 Diff](reports/metric/compares/diff_51813f5_e5d1e16.md) |
| 7 | [`c998399`](https://github.com/gnoswap-labs/gnoswap/tree/c998399) | Replace int256 with int64 for router swap | [📊 Report](reports/metric/commits/c998399.md) | [📈 Diff](reports/metric/compares/diff_c998399_51813f5.md) | [📊 Diff](reports/metric/compares/diff_c998399_e5d1e16.md) |
| 8 | [`aa648b2`](https://github.com/gnoswap-labs/gnoswap/tree/aa648b2) | Optimize KVStore.makeKey | [📊 Report](reports/metric/commits/aa648b2.md) | [📈 Diff](reports/metric/compares/diff_aa648b2_c998399.md) | [📊 Diff](reports/metric/compares/diff_aa648b2_e5d1e16.md) |
| 9 | [`3a818d3`](https://github.com/gnoswap-labs/gnoswap/tree/3a818d3) | Optimize Router | [📊 Report](reports/metric/commits/3a818d3.md) | [📈 Diff](reports/metric/compares/diff_3a818d3_aa648b2.md) | [📊 Diff](reports/metric/compares/diff_3a818d3_e5d1e16.md) |
| 10 | [`9ee6b50`](https://github.com/gnoswap-labs/gnoswap/tree/9ee6b50) | Optimize GNFT | [📊 Report](reports/metric/commits/9ee6b50.md) | [📈 Diff](reports/metric/compares/diff_9ee6b50_3a818d3.md) | [📊 Diff](reports/metric/compares/diff_9ee6b50_e5d1e16.md) |
| 11 | [`a7e1bc3`](https://github.com/gnoswap-labs/gnoswap/tree/a7e1bc3) | Make stake use AVL tree | [📊 Report](reports/metric/commits/a7e1bc3.md) | [📈 Diff](reports/metric/compares/diff_a7e1bc3_9ee6b50.md) | [📊 Diff](reports/metric/compares/diff_a7e1bc3_e5d1e16.md) |
| 12 | [`e59f3c1`](https://github.com/gnoswap-labs/gnoswap/tree/e59f3c1) | Optimize position | [📊 Report](reports/metric/commits/e59f3c1.md) | [📈 Diff](reports/metric/compares/diff_e59f3c1_a7e1bc3.md) | [📊 Diff](reports/metric/compares/diff_e59f3c1_e5d1e16.md) |
| 13 | [`ba942e9`](https://github.com/gnoswap-labs/gnoswap/tree/ba942e9) | Optimize staker | [📊 Report](reports/metric/commits/ba942e9.md) | [📈 Diff](reports/metric/compares/diff_ba942e9_e59f3c1.md) | [📊 Diff](reports/metric/compares/diff_ba942e9_e5d1e16.md) |
| 14 | [`2b031c5`](https://github.com/gnoswap-labs/gnoswap/tree/2b031c5) | Finalize Optimization | [📊 Report](reports/metric/commits/2b031c5.md) | [📈 Diff](reports/metric/compares/diff_2b031c5_ba942e9.md) | [📊 Diff](reports/metric/compares/diff_2b031c5_e5d1e16.md) |

---

## Overall Comparison (First → Latest)

**[`e5d1e16` → `2b031c5`](reports/metric/compares/diff_2b031c5_e5d1e16.md)**

This comparison shows the total gas usage changes between the baseline commit and the latest commit.

### Quick Stats

| Metric | Count |
|--------|-------|
| ⚡️ Improvements | 293 |
| ⚠️ Regressions | 21 |

### Detailed Comparison

| Name | Metric | Latest | Previous | Change | % |
|------|--------|--------|----------|--------|---|
| **TickMathGetSqrtRatioAtTick (minTick)** | Gas Used | 1,554,700 | 2,868,084 | -1,313,384 | ⚡️ -45.79% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 677,324 | 1,926,276 | -1,248,952 | ⚡️ -64.84% |
| **TickMathGetSqrtRatioAtTick (maxTick)** | Gas Used | 873,832 | 2,141,817 | -1,267,985 | ⚡️ -59.20% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 863,400 | 2,126,105 | -1,262,705 | ⚡️ -59.39% |
| **TickMathGetSqrtRatioAtTick (zero)** | Gas Used | 134,165 | 137,023 | -2,858 | ⚡️ -2.09% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 134,165 | 137,023 | -2,858 | ⚡️ -2.09% |
| **TickMathGetSqrtRatioAtTick** | Gas Used | 652,352 | 1,429,945 | -777,593 | ⚡️ -54.38% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 641,936 | 1,414,233 | -772,297 | ⚡️ -54.61% |
| **TickMathGetTickAtSqrtRatio** | Gas Used | 1,792,151 | 4,237,459 | -2,445,308 | ⚡️ -57.71% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 1,635,447 | 3,974,547 | -2,339,100 | ⚡️ -58.85% |
| **GetLiquidityForAmounts** | Gas Used | 1,442,983 | 2,392,306 | -949,323 | ⚡️ -39.68% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 1,422,279 | 2,360,930 | -938,651 | ⚡️ -39.76% |
| **GetAmountsForLiquidity** | Gas Used | 1,333,931 | 2,148,786 | -814,855 | ⚡️ -37.92% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 1,333,931 | 2,148,786 | -814,855 | ⚡️ -37.92% |
| **LiquidityMathAddDelta (positive)** | Gas Used | 220,687 | 198,435 | +22,252 | ⚠️ 11.21% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 187,647 | 198,435 | -10,788 | ⚡️ -5.44% |
| **LiquidityMathAddDelta (negative)** | Gas Used | 200,681 | 189,963 | +10,718 | ⚠️ 5.64% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 200,681 | 189,963 | +10,718 | ⚠️ 5.64% |
| **LiquidityMathAddDelta** | Gas Used | 187,647 | 198,435 | -10,788 | ⚡️ -5.44% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 187,647 | 198,435 | -10,788 | ⚡️ -5.44% |
| **IsGNOTPath** | Gas Used | 11,223 | 11,223 | 0 |  0.00% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 11,223 | 11,223 | 0 |  0.00% |
| **IsGNOTNativePath** | Gas Used | 11,175 | 11,175 | 0 |  0.00% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 11,175 | 11,175 | 0 |  0.00% |
| **IsGNOTWrappedPath** | Gas Used | 11,175 | 11,175 | 0 |  0.00% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 11,175 | 11,175 | 0 |  0.00% |
| **ExistsUserSendCoins** | Gas Used | 266,478 | 266,478 | 0 |  0.00% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 18,206 | 18,206 | 0 |  0.00% |
| **GetAmount0Delta** | Gas Used | 3,912,271 | 5,830,275 | -1,918,004 | ⚡️ -32.90% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 1,486,687 | 3,357,715 | -1,871,028 | ⚡️ -55.72% |
| **GetAmount1Delta** | Gas Used | 1,050,599 | 2,936,180 | -1,885,581 | ⚡️ -64.22% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 1,040,247 | 2,920,468 | -1,880,221 | ⚡️ -64.38% |
| **SwapMathComputeSwapStep** | Gas Used | 1,879,867 | 5,626,580 | -3,746,713 | ⚡️ -66.59% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 1,859,003 | 5,595,156 | -3,736,153 | ⚡️ -66.77% |
| **Propose Community Pool Spend** | Gas Used | 2,403,657 | 1,600,112 | +803,545 | ⚠️ 50.22% |
| | Storage Diff | 13,365 | 14,171 | -806 | ⚡️ -5.69% |
| | CPU Cycles | 874,581 | 1,214,272 | -339,691 | ⚡️ -27.97% |
| **Propose Parameter Change** | Gas Used | 2,525,445 | 2,571,829 | -46,384 | ⚡️ -1.80% |
| | Storage Diff | 13,200 | 14,006 | -806 | ⚡️ -5.75% |
| | CPU Cycles | 1,515,493 | 1,812,693 | -297,200 | ⚡️ -16.40% |
| **Vote** | Gas Used | 810,907 | 394,634 | +416,273 | ⚠️ 105.48% |
| | Storage Diff | 2,170 | 80 | +2,090 | ⚠️ 2612.50% |
| | CPU Cycles | 581,077 | 273,546 | +307,531 | ⚠️ 112.42% |
| **Execute** | Gas Used | 3,708,068 | 3,799,026 | -90,958 | ⚡️ -2.39% |
| | Storage Diff | 76 | 76 | 0 |  0.00% |
| | CPU Cycles | 582,412 | 688,298 | -105,886 | ⚡️ -15.38% |
| **Propose Text** | Gas Used | 1,078,385 | 1,427,855 | -349,470 | ⚡️ -24.48% |
| | Storage Diff | 12,739 | 13,545 | -806 | ⚡️ -5.95% |
| | CPU Cycles | 718,241 | 1,051,711 | -333,470 | ⚡️ -31.71% |
| **Propose Text with Inactive: 100** | Gas Used | 1,866,460 | 13,531,326 | -11,664,866 | ⚡️ -86.21% |
| | Storage Diff | 13,252 | 14,102 | -850 | ⚡️ -6.03% |
| | CPU Cycles | 1,092,063 | 12,682,065 | -11,590,002 | ⚡️ -91.39% |
| **CollectUndelegatedGns (100 delegations, 1 withdraws)** | Gas Used | 96,257,252 | 153,034,501 | -56,777,249 | ⚡️ -37.10% |
| | Storage Diff | -5,987,528 | -5,985,986 | -1,542 | ⚡️ -0.03% |
| | CPU Cycles | 55,805,444 | 112,625,659 | -56,820,215 | ⚡️ -50.45% |
| **CollectUndelegatedGns (10 delegations, 10 withdraws)** | Gas Used | 12,872,544 | 19,980,991 | -7,108,447 | ⚡️ -35.58% |
| | Storage Diff | -646,747 | -646,658 | -89 | ⚡️ -0.01% |
| | CPU Cycles | 8,253,206 | 15,404,491 | -7,151,285 | ⚡️ -46.42% |
| **CollectUndelegatedGns (10 delegations, 1 withdraws)** | Gas Used | 3,524,265 | 6,382,642 | -2,858,377 | ⚡️ -44.78% |
| | Storage Diff | -98,656 | -98,551 | -105 | ⚡️ -0.11% |
| | CPU Cycles | 2,582,777 | 5,483,992 | -2,901,215 | ⚡️ -52.90% |
| **CollectUndelegatedGns (10 delegations, 50 withdraws)** | Gas Used | 54,405,708 | 80,403,243 | -25,997,535 | ⚡️ -32.33% |
| | Storage Diff | -3,099,833 | -3,097,986 | -1,847 | ⚡️ -0.06% |
| | CPU Cycles | 33,439,606 | 59,480,091 | -26,040,485 | ⚡️ -43.78% |
| **CollectUndelegatedGns (10 delegations, 5 withdraws)** | Gas Used | 7,677,505 | 12,424,802 | -4,747,297 | ⚡️ -38.21% |
| | Storage Diff | -342,286 | -342,189 | -97 | ⚡️ -0.03% |
| | CPU Cycles | 5,101,417 | 9,891,552 | -4,790,135 | ⚡️ -48.43% |
| **CollectUndelegatedGns (1 delegation, 10 withdraws)** | Gas Used | 1,129,258 | 1,560,800 | -431,542 | ⚡️ -27.65% |
| | Storage Diff | -16,635 | -16,653 | +18 | ⚠️ 0.11% |
| | CPU Cycles | 761,861 | 1,276,033 | -514,172 | ⚡️ -40.29% |
| **CollectUndelegatedGns (1 delegation, 1 withdraws)** | Gas Used | 730,705 | 995,225 | -264,520 | ⚡️ -26.58% |
| | Storage Diff | -6,726 | -6,744 | +18 | ⚠️ 0.27% |
| | CPU Cycles | 430,178 | 777,328 | -347,150 | ⚡️ -44.66% |
| **CollectUndelegatedGns (1 delegation, 50 withdraws)** | Gas Used | 2,894,338 | 4,068,136 | -1,173,798 | ⚡️ -28.85% |
| | Storage Diff | -60,845 | -60,777 | -68 | ⚡️ -0.11% |
| | CPU Cycles | 2,229,661 | 3,486,153 | -1,256,492 | ⚡️ -36.04% |
| **CollectUndelegatedGns (1 delegation, 5 withdraws)** | Gas Used | 907,205 | 1,245,957 | -338,752 | ⚡️ -27.19% |
| | Storage Diff | -11,130 | -11,148 | +18 | ⚠️ 0.16% |
| | CPU Cycles | 576,958 | 998,340 | -421,382 | ⚡️ -42.21% |
| **CollectReward (100 delegations, 1 withdraws)** | Gas Used | 1,332,834 | 1,992,217 | -659,383 | ⚡️ -33.10% |
| | Storage Diff | 1,384 | 3,093 | -1,709 | ⚡️ -55.25% |
| | CPU Cycles | 809,013 | 1,407,594 | -598,581 | ⚡️ -42.53% |
| **CollectReward (10 delegations, 10 withdraws)** | Gas Used | 1,331,766 | 1,990,797 | -659,031 | ⚡️ -33.10% |
| | Storage Diff | 1,378 | 3,075 | -1,697 | ⚡️ -55.19% |
| | CPU Cycles | 809,013 | 1,407,594 | -598,581 | ⚡️ -42.53% |
| **CollectReward (10 delegations, 1 withdraws)** | Gas Used | 1,331,418 | 1,990,449 | -659,031 | ⚡️ -33.11% |
| | Storage Diff | 1,378 | 3,075 | -1,697 | ⚡️ -55.19% |
| | CPU Cycles | 808,665 | 1,407,246 | -598,581 | ⚡️ -42.54% |
| **CollectReward (10 delegations, 50 withdraws)** | Gas Used | 1,331,766 | 1,990,797 | -659,031 | ⚡️ -33.10% |
| | Storage Diff | 1,378 | 3,075 | -1,697 | ⚡️ -55.19% |
| | CPU Cycles | 809,013 | 1,407,594 | -598,581 | ⚡️ -42.53% |
| **CollectReward (10 delegations, 5 withdraws)** | Gas Used | 1,331,477 | 1,990,508 | -659,031 | ⚡️ -33.11% |
| | Storage Diff | 1,378 | 3,075 | -1,697 | ⚡️ -55.19% |
| | CPU Cycles | 808,724 | 1,407,305 | -598,581 | ⚡️ -42.53% |
| **CollectReward (1 delegation, 10 withdraws)** | Gas Used | 2,015,188 | 2,679,403 | -664,215 | ⚡️ -24.79% |
| | Storage Diff | 1,409 | 3,106 | -1,697 | ⚡️ -54.64% |
| | CPU Cycles | 808,019 | 1,406,600 | -598,581 | ⚡️ -42.56% |
| **CollectReward (1 delegation, 1 withdraws)** | Gas Used | 2,010,080 | 2,683,740 | -673,660 | ⚡️ -25.10% |
| | Storage Diff | 1,409 | 3,106 | -1,697 | ⚡️ -54.64% |
| | CPU Cycles | 802,911 | 1,410,937 | -608,026 | ⚡️ -43.09% |
| **CollectReward (1 delegation, 50 withdraws)** | Gas Used | 2,015,247 | 2,679,462 | -664,215 | ⚡️ -24.79% |
| | Storage Diff | 1,409 | 3,106 | -1,697 | ⚡️ -54.64% |
| | CPU Cycles | 808,078 | 1,406,659 | -598,581 | ⚡️ -42.55% |
| **CollectReward (1 delegation, 5 withdraws)** | Gas Used | 2,015,188 | 2,679,403 | -664,215 | ⚡️ -24.79% |
| | Storage Diff | 1,409 | 3,106 | -1,697 | ⚡️ -54.64% |
| | CPU Cycles | 808,019 | 1,406,600 | -598,581 | ⚡️ -42.56% |
| **Delegate** | Gas Used | 8,452,820 | 9,759,051 | -1,306,231 | ⚡️ -13.38% |
| | Storage Diff | 19,253 | 15,294 | +3,959 | ⚠️ 25.89% |
| | CPU Cycles | 889,609 | 1,498,189 | -608,580 | ⚡️ -40.62% |
| **Undelegate** | Gas Used | 2,508,386 | 2,608,859 | -100,473 | ⚡️ -3.85% |
| | Storage Diff | 1,356 | 1,334 | +22 | ⚠️ 1.65% |
| | CPU Cycles | 1,279,885 | 1,423,190 | -143,305 | ⚡️ -10.07% |
| **Undelegate (5 delegations, cached external calls)** | Gas Used | 7,167,000 | 7,556,942 | -389,942 | ⚡️ -5.16% |
| | Storage Diff | 5,530 | 10,634 | -5,104 | ⚡️ -48.00% |
| | CPU Cycles | 5,947,928 | 6,273,361 | -325,433 | ⚡️ -5.19% |
| **Delegate (cached external calls)** | Gas Used | 2,339,658 | 2,634,854 | -295,196 | ⚡️ -11.20% |
| | Storage Diff | 10,559 | 6,406 | +4,153 | ⚠️ 64.83% |
| | CPU Cycles | 1,270,887 | 1,591,363 | -320,476 | ⚡️ -20.14% |
| **Undelegate (early exit, 3 of 10 delegations)** | Gas Used | 4,703,958 | 5,553,687 | -849,729 | ⚡️ -15.30% |
| | Storage Diff | 3,324 | 7,017 | -3,693 | ⚡️ -52.63% |
| | CPU Cycles | 3,702,426 | 4,414,410 | -711,984 | ⚡️ -16.13% |
| **Redelegate** | Gas Used | 3,358,228 | 3,041,372 | +316,856 | ⚠️ 10.42% |
| | Storage Diff | 10,812 | 7,524 | +3,288 | ⚠️ 43.70% |
| | CPU Cycles | 1,943,618 | 1,762,067 | +181,551 | ⚠️ 10.30% |
| **Redelegate (50 of 100 delegations, optimized)** | Gas Used | 51,220,528 | 15,945,171 | +35,275,357 | ⚠️ 221.23% |
| | Storage Diff | 10,845 | 62,757 | -51,912 | ⚡️ -82.72% |
| | CPU Cycles | 46,672,445 | 11,185,137 | +35,487,308 | ⚠️ 317.27% |
| **Undelegate (50 delegatees, large AVL traversal)** | Gas Used | 2,293,636 | 2,875,443 | -581,807 | ⚡️ -20.23% |
| | Storage Diff | 1,155 | 1,321 | -166 | ⚡️ -12.57% |
| | CPU Cycles | 1,387,684 | 1,470,250 | -82,566 | ⚡️ -5.62% |
| **Launchpad CollectDepositGns** | Gas Used | 1,831,823 | 2,926,151 | -1,094,328 | ⚡️ -37.40% |
| | Storage Diff | -3,910 | 45 | -3,955 | ⚡️ -8788.89% |
| | CPU Cycles | 912,080 | 1,937,295 | -1,025,215 | ⚡️ -52.92% |
| **CollectProtocolFee (1 token)** | Gas Used | 1,424,067 | 2,324,539 | -900,472 | ⚡️ -38.74% |
| | Storage Diff | 3,422 | 5,118 | -1,696 | ⚡️ -33.14% |
| | CPU Cycles | 877,328 | 1,712,278 | -834,950 | ⚡️ -48.76% |
| **CollectProtocolFee (2 tokens)** | Gas Used | 2,093,434 | 3,193,200 | -1,099,766 | ⚡️ -34.44% |
| | Storage Diff | 6,803 | 10,194 | -3,391 | ⚡️ -33.26% |
| | CPU Cycles | 1,372,593 | 2,369,852 | -997,259 | ⚡️ -42.08% |
| **CollectProtocolFee (5 tokens)** | Gas Used | 4,138,855 | 5,836,503 | -1,697,648 | ⚡️ -29.09% |
| | Storage Diff | 16,938 | 25,414 | -8,476 | ⚡️ -33.35% |
| | CPU Cycles | 2,865,450 | 4,349,636 | -1,484,186 | ⚡️ -34.12% |
| **Launchpad CollectProtocolFee (tokens: 10)** | Gas Used | 7,537,053 | 10,231,651 | -2,694,598 | ⚡️ -26.34% |
| | Storage Diff | 34,088 | 51,069 | -16,981 | ⚡️ -33.25% |
| | CPU Cycles | 5,332,940 | 7,628,671 | -2,295,731 | ⚡️ -30.09% |
| **Launchpad CollectRewardByDepositId** | Gas Used | 825,809 | 1,273,493 | -447,684 | ⚡️ -35.15% |
| | Storage Diff | 2,028 | 2,028 | 0 |  0.00% |
| | CPU Cycles | 513,793 | 952,402 | -438,609 | ⚡️ -46.05% |
| **Create Launchpad Project** | Gas Used | 10,369,498 | 11,474,918 | -1,105,420 | ⚡️ -9.63% |
| | Storage Diff | 28,808 | 31,958 | -3,150 | ⚡️ -9.86% |
| | CPU Cycles | 1,856,886 | 2,424,162 | -567,276 | ⚡️ -23.40% |
| **Launchpad DepositGns** | Gas Used | 6,076,865 | 7,298,488 | -1,221,623 | ⚡️ -16.74% |
| | Storage Diff | 12,107 | 12,982 | -875 | ⚡️ -6.74% |
| | CPU Cycles | 1,253,618 | 2,244,356 | -990,738 | ⚡️ -44.14% |
| **Launchpad TransferLeftFromProjectByAdmin** | Gas Used | 1,240,925 | 1,350,088 | -109,163 | ⚡️ -8.09% |
| | Storage Diff | 5 | 5 | 0 |  0.00% |
| | CPU Cycles | 446,881 | 562,412 | -115,531 | ⚡️ -20.54% |
| **CreatePool** | Gas Used | 8,609,165 | 12,517,546 | -3,908,381 | ⚡️ -31.22% |
| | Storage Diff | 18,536 | 21,680 | -3,144 | ⚡️ -14.50% |
| | CPU Cycles | 2,309,669 | 5,701,506 | -3,391,837 | ⚡️ -59.49% |
| **Mint (fee:3000, wide range)** | Gas Used | 17,594,367 | 39,101,721 | -21,507,354 | ⚡️ -55.00% |
| | Storage Diff | 40,612 | 52,800 | -12,188 | ⚡️ -23.08% |
| | CPU Cycles | 11,543,777 | 32,673,621 | -21,129,844 | ⚡️ -64.67% |
| **Swap (gns -> wugnot, fee:500)** | Gas Used | 30,769,557 | 81,918,431 | -51,148,874 | ⚡️ -62.44% |
| | Storage Diff | 19,749 | 22,199 | -2,450 | ⚡️ -11.04% |
| | CPU Cycles | 20,644,215 | 71,704,291 | -51,060,076 | ⚡️ -71.21% |
| **DecreaseLiquidity** | Gas Used | 12,621,112 | 24,327,552 | -11,706,440 | ⚡️ -48.12% |
| | Storage Diff | 58 | 72 | -14 | ⚡️ -19.44% |
| | CPU Cycles | 9,826,573 | 21,291,144 | -11,464,571 | ⚡️ -53.85% |
| **IncreaseLiquidity** | Gas Used | 10,544,756 | 23,198,296 | -12,653,540 | ⚡️ -54.55% |
| | Storage Diff | -2,064 | -2,022 | -42 | ⚡️ -2.08% |
| | CPU Cycles | 9,460,572 | 21,925,540 | -12,464,968 | ⚡️ -56.85% |
| **Mint (bar:foo:500)** | Gas Used | 20,289,672 | 39,889,642 | -19,599,970 | ⚡️ -49.14% |
| | Storage Diff | 40,589 | 52,777 | -12,188 | ⚡️ -23.09% |
| | CPU Cycles | 10,601,454 | 29,802,270 | -19,200,816 | ⚡️ -64.43% |
| **Mint (w. GNOT)** | Gas Used | 23,320,093 | 44,200,360 | -20,880,267 | ⚡️ -47.24% |
| | Storage Diff | 39,631 | 51,818 | -12,187 | ⚡️ -23.52% |
| | CPU Cycles | 12,075,961 | 33,206,418 | -21,130,457 | ⚡️ -63.63% |
| **IncreaseLiquidity (w. GNOT)** | Gas Used | 12,157,040 | 27,321,932 | -15,164,892 | ⚡️ -55.50% |
| | Storage Diff | 56 | 98 | -42 | ⚡️ -42.86% |
| | CPU Cycles | 10,820,480 | 25,796,800 | -14,976,320 | ⚡️ -58.05% |
| **DecreaseLiquidity (unwrap=false)** | Gas Used | 15,366,478 | 28,781,287 | -13,414,809 | ⚡️ -46.61% |
| | Storage Diff | 6,396 | 6,369 | +27 | ⚠️ 0.42% |
| | CPU Cycles | 10,447,439 | 23,596,907 | -13,149,468 | ⚡️ -55.73% |
| **CollectFee (with unwrap)** | Gas Used | 3,659,583 | 6,364,089 | -2,704,506 | ⚡️ -42.50% |
| | Storage Diff | 40 | 44 | -4 | ⚡️ -9.09% |
| | CPU Cycles | 2,409,864 | 5,059,920 | -2,650,056 | ⚡️ -52.37% |
| **DecreaseLiquidity (w. Remove)** | Gas Used | 13,299,112 | 24,765,751 | -11,466,639 | ⚡️ -46.30% |
| | Storage Diff | 4,370 | 4,406 | -36 | ⚡️ -0.82% |
| | CPU Cycles | 9,178,105 | 20,382,247 | -11,204,142 | ⚡️ -54.97% |
| **Mint (reposition)** | Gas Used | 12,286,047 | 31,711,435 | -19,425,388 | ⚡️ -61.26% |
| | Storage Diff | 33,714 | 45,256 | -11,542 | ⚡️ -25.50% |
| | CPU Cycles | 10,681,615 | 29,883,427 | -19,201,812 | ⚡️ -64.26% |
| **SetPoolTier (tier 1)** | Gas Used | 4,772,198 | 5,375,292 | -603,094 | ⚡️ -11.22% |
| | Storage Diff | 21,413 | 22,952 | -1,539 | ⚡️ -6.71% |
| | CPU Cycles | 1,442,912 | 2,281,958 | -839,046 | ⚡️ -36.77% |
| **StakeToken** | Gas Used | 8,558,092 | 11,764,730 | -3,206,638 | ⚡️ -27.26% |
| | Storage Diff | 23,438 | 25,068 | -1,630 | ⚡️ -6.50% |
| | CPU Cycles | 4,824,997 | 7,968,981 | -3,143,984 | ⚡️ -39.45% |
| **ExactInSingleSwapRoute(grc20) - fee:10000** | Gas Used | 28,135,033 | 40,356,458 | -12,221,425 | ⚡️ -30.28% |
| | Storage Diff | 5,002 | 5,352 | -350 | ⚡️ -6.54% |
| | CPU Cycles | 11,364,713 | 23,356,588 | -11,991,875 | ⚡️ -51.34% |
| **ExactInSingleSwapRoute(grc20) - fee:100** | Gas Used | 30,183,946 | 48,858,543 | -18,674,597 | ⚡️ -38.22% |
| | Storage Diff | 7,819 | 8,519 | -700 | ⚡️ -8.22% |
| | CPU Cycles | 13,412,042 | 31,873,057 | -18,461,015 | ⚡️ -57.92% |
| **ExactInSingleSwapRoute(grc20) - fee:3000** | Gas Used | 28,569,621 | 40,839,268 | -12,269,647 | ⚡️ -30.04% |
| | Storage Diff | 5,004 | 5,361 | -357 | ⚡️ -6.66% |
| | CPU Cycles | 11,375,852 | 23,438,733 | -12,062,881 | ⚡️ -51.47% |
| **ExactInSingleSwapRoute(grc20) - fee:500** | Gas Used | 28,015,888 | 40,188,360 | -12,172,472 | ⚡️ -30.29% |
| | Storage Diff | 5,002 | 5,352 | -350 | ⚡️ -6.54% |
| | CPU Cycles | 11,287,152 | 23,251,322 | -11,964,170 | ⚡️ -51.46% |
| **ExactInSingleSwapRoute(ugnot) - fee:10000** | Gas Used | 29,403,525 | 44,281,410 | -14,877,885 | ⚡️ -33.60% |
| | Storage Diff | 7,834 | 8,534 | -700 | ⚡️ -8.20% |
| | CPU Cycles | 12,397,343 | 27,035,694 | -14,638,351 | ⚡️ -54.14% |
| **ExactInSingleSwapRoute(ugnot) - fee:100** | Gas Used | 31,029,448 | 52,767,896 | -21,738,448 | ⚡️ -41.20% |
| | Storage Diff | 10,655 | 11,705 | -1,050 | ⚡️ -8.97% |
| | CPU Cycles | 13,990,370 | 35,489,364 | -21,498,994 | ⚡️ -60.58% |
| **ExactInSingleSwapRoute(ugnot) - fee:3000** | Gas Used | 29,935,984 | 45,059,192 | -15,123,208 | ⚡️ -33.56% |
| | Storage Diff | 7,836 | 8,543 | -707 | ⚡️ -8.28% |
| | CPU Cycles | 12,495,873 | 27,397,099 | -14,901,226 | ⚡️ -54.39% |
| **ExactInSingleSwapRoute(ugnot) - fee:500** | Gas Used | 29,273,736 | 44,039,564 | -14,765,828 | ⚡️ -33.53% |
| | Storage Diff | 7,835 | 8,535 | -700 | ⚡️ -8.20% |
| | CPU Cycles | 12,288,226 | 26,825,240 | -14,537,014 | ⚡️ -54.19% |
| **ExactInSwapRoute(grc20) - fee:10000** | Gas Used | 27,874,742 | 40,123,232 | -12,248,490 | ⚡️ -30.53% |
| | Storage Diff | 5,002 | 5,352 | -350 | ⚡️ -6.54% |
| | CPU Cycles | 11,104,422 | 23,123,362 | -12,018,940 | ⚡️ -51.98% |
| **ExactInSwapRoute(grc20) - fee:100** | Gas Used | 29,930,199 | 48,631,861 | -18,701,662 | ⚡️ -38.46% |
| | Storage Diff | 7,819 | 8,519 | -700 | ⚡️ -8.22% |
| | CPU Cycles | 13,158,295 | 31,646,375 | -18,488,080 | ⚡️ -58.42% |
| **ExactInSwapRoute(grc20) - fee:3000** | Gas Used | 28,312,602 | 40,609,314 | -12,296,712 | ⚡️ -30.28% |
| | Storage Diff | 5,004 | 5,361 | -357 | ⚡️ -6.66% |
| | CPU Cycles | 11,118,833 | 23,208,779 | -12,089,946 | ⚡️ -52.09% |
| **ExactInSwapRoute(grc20) - fee:500** | Gas Used | 27,762,141 | 39,961,678 | -12,199,537 | ⚡️ -30.53% |
| | Storage Diff | 5,002 | 5,352 | -350 | ⚡️ -6.54% |
| | CPU Cycles | 11,033,405 | 23,024,640 | -11,991,235 | ⚡️ -52.08% |
| **ExactInSwapRoute(ugnot) - fee:10000** | Gas Used | 29,143,234 | 44,048,184 | -14,904,950 | ⚡️ -33.84% |
| | Storage Diff | 7,834 | 8,534 | -700 | ⚡️ -8.20% |
| | CPU Cycles | 12,137,052 | 26,802,468 | -14,665,416 | ⚡️ -54.72% |
| **ExactInSwapRoute(ugnot) - fee:100** | Gas Used | 30,775,701 | 52,541,214 | -21,765,513 | ⚡️ -41.43% |
| | Storage Diff | 10,655 | 11,705 | -1,050 | ⚡️ -8.97% |
| | CPU Cycles | 13,736,623 | 35,262,682 | -21,526,059 | ⚡️ -61.04% |
| **ExactInSwapRoute(ugnot) - fee:3000** | Gas Used | 29,678,965 | 44,829,238 | -15,150,273 | ⚡️ -33.80% |
| | Storage Diff | 7,836 | 8,543 | -707 | ⚡️ -8.28% |
| | CPU Cycles | 12,238,854 | 27,167,145 | -14,928,291 | ⚡️ -54.95% |
| **ExactInSwapRoute(ugnot) - fee:500** | Gas Used | 29,019,989 | 43,812,882 | -14,792,893 | ⚡️ -33.76% |
| | Storage Diff | 7,835 | 8,535 | -700 | ⚡️ -8.20% |
| | CPU Cycles | 12,034,479 | 26,598,558 | -14,564,079 | ⚡️ -54.76% |
| **ExactOutSingleSwapRoute(grc20) - fee:10000** | Gas Used | 28,926,081 | 44,523,606 | -15,597,525 | ⚡️ -35.03% |
| | Storage Diff | 5,002 | 5,352 | -350 | ⚡️ -6.54% |
| | CPU Cycles | 12,166,113 | 27,555,160 | -15,389,047 | ⚡️ -55.85% |
| **ExactOutSingleSwapRoute(grc20) - fee:100** | Gas Used | 30,904,949 | 52,697,454 | -21,792,505 | ⚡️ -41.35% |
| | Storage Diff | 7,819 | 8,519 | -700 | ⚡️ -8.22% |
| | CPU Cycles | 14,143,397 | 35,727,680 | -21,584,283 | ⚡️ -60.41% |
| **ExactOutSingleSwapRoute(grc20) - fee:3000** | Gas Used | 29,295,208 | 44,859,368 | -15,564,160 | ⚡️ -34.70% |
| | Storage Diff | 5,004 | 5,361 | -357 | ⚡️ -6.66% |
| | CPU Cycles | 12,122,143 | 27,505,969 | -15,383,826 | ⚡️ -55.93% |
| **ExactOutSingleSwapRoute(grc20) - fee:500** | Gas Used | 28,756,208 | 44,191,307 | -15,435,099 | ⚡️ -34.93% |
| | Storage Diff | 5,002 | 5,352 | -350 | ⚡️ -6.54% |
| | CPU Cycles | 12,048,176 | 27,301,405 | -15,253,229 | ⚡️ -55.87% |
| **ExactOutSingleSwapRoute(ugnot) - fee:10000** | Gas Used | 29,802,159 | 44,620,959 | -14,818,800 | ⚡️ -33.21% |
| | Storage Diff | 7,844 | 8,544 | -700 | ⚡️ -8.19% |
| | CPU Cycles | 12,497,591 | 27,071,497 | -14,573,906 | ⚡️ -53.83% |
| **ExactOutSingleSwapRoute(ugnot) - fee:100** | Gas Used | 31,302,178 | 51,386,693 | -20,084,515 | ⚡️ -39.09% |
| | Storage Diff | 10,665 | 11,715 | -1,050 | ⚡️ -8.96% |
| | CPU Cycles | 13,975,066 | 33,820,127 | -19,845,061 | ⚡️ -58.68% |
| **ExactOutSingleSwapRoute(ugnot) - fee:3000** | Gas Used | 30,239,383 | 45,166,820 | -14,927,437 | ⚡️ -33.05% |
| | Storage Diff | 7,846 | 8,553 | -707 | ⚡️ -8.27% |
| | CPU Cycles | 12,511,238 | 27,216,693 | -14,705,455 | ⚡️ -54.03% |
| **ExactOutSingleSwapRoute(ugnot) - fee:500** | Gas Used | 29,600,986 | 44,166,261 | -14,565,275 | ⚡️ -32.98% |
| | Storage Diff | 7,845 | 8,545 | -700 | ⚡️ -8.19% |
| | CPU Cycles | 12,327,442 | 26,663,903 | -14,336,461 | ⚡️ -53.77% |
| **ExactOutSwapRoute(grc20) - fee:10000** | Gas Used | 28,677,078 | 44,300,488 | -15,623,410 | ⚡️ -35.27% |
| | Storage Diff | 5,002 | 5,352 | -350 | ⚡️ -6.54% |
| | CPU Cycles | 11,917,110 | 27,332,042 | -15,414,932 | ⚡️ -56.40% |
| **ExactOutSwapRoute(grc20) - fee:100** | Gas Used | 30,662,490 | 52,480,880 | -21,818,390 | ⚡️ -41.57% |
| | Storage Diff | 7,819 | 8,519 | -700 | ⚡️ -8.22% |
| | CPU Cycles | 13,900,938 | 35,511,106 | -21,610,168 | ⚡️ -60.85% |
| **ExactOutSwapRoute(grc20) - fee:3000** | Gas Used | 29,049,477 | 44,639,522 | -15,590,045 | ⚡️ -34.92% |
| | Storage Diff | 5,004 | 5,361 | -357 | ⚡️ -6.66% |
| | CPU Cycles | 11,876,412 | 27,286,123 | -15,409,711 | ⚡️ -56.47% |
| **ExactOutSwapRoute(grc20) - fee:500** | Gas Used | 28,513,749 | 43,974,733 | -15,460,984 | ⚡️ -35.16% |
| | Storage Diff | 5,002 | 5,352 | -350 | ⚡️ -6.54% |
| | CPU Cycles | 11,805,717 | 27,084,831 | -15,279,114 | ⚡️ -56.41% |
| **ExactOutSwapRoute(ugnot) - fee:10000** | Gas Used | 29,553,156 | 44,397,841 | -14,844,685 | ⚡️ -33.44% |
| | Storage Diff | 7,844 | 8,544 | -700 | ⚡️ -8.19% |
| | CPU Cycles | 12,248,588 | 26,848,379 | -14,599,791 | ⚡️ -54.38% |
| **ExactOutSwapRoute(ugnot) - fee:100** | Gas Used | 31,059,719 | 51,170,119 | -20,110,400 | ⚡️ -39.30% |
| | Storage Diff | 10,665 | 11,715 | -1,050 | ⚡️ -8.96% |
| | CPU Cycles | 13,732,607 | 33,603,553 | -19,870,946 | ⚡️ -59.13% |
| **ExactOutSwapRoute(ugnot) - fee:3000** | Gas Used | 29,993,652 | 44,946,974 | -14,953,322 | ⚡️ -33.27% |
| | Storage Diff | 7,846 | 8,553 | -707 | ⚡️ -8.27% |
| | CPU Cycles | 12,265,507 | 26,996,847 | -14,731,340 | ⚡️ -54.57% |
| **ExactOutSwapRoute(ugnot) - fee:500** | Gas Used | 29,358,527 | 43,949,687 | -14,591,160 | ⚡️ -33.20% |
| | Storage Diff | 7,845 | 8,545 | -700 | ⚡️ -8.19% |
| | CPU Cycles | 12,084,983 | 26,447,329 | -14,362,346 | ⚡️ -54.31% |
| **BuildSingleHopRoutePath** | Gas Used | 1,710,230 | 2,012,694 | -302,464 | ⚡️ -15.03% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 23,398 | 80,758 | -57,360 | ⚡️ -71.03% |
| **MultiHop ExactIn (2 hops)** | Gas Used | 31,283,172 | 57,335,424 | -26,052,252 | ⚡️ -45.44% |
| | Storage Diff | 10,674 | 11,724 | -1,050 | ⚡️ -8.96% |
| | CPU Cycles | 22,629,566 | 48,812,654 | -26,183,088 | ⚡️ -53.64% |
| **MultiHop ExactOut (2 hops)** | Gas Used | 35,588,031 | 85,964,234 | -50,376,203 | ⚡️ -58.60% |
| | Storage Diff | 26 | 26 | 0 |  0.00% |
| | CPU Cycles | 34,014,965 | 84,534,948 | -50,519,983 | ⚡️ -59.76% |
| **MultiHop ExactIn (3 hops)** | Gas Used | 35,325,224 | 71,650,323 | -36,325,099 | ⚡️ -50.70% |
| | Storage Diff | 5,709 | 6,492 | -783 | ⚡️ -12.06% |
| | CPU Cycles | 33,005,194 | 69,542,075 | -36,536,881 | ⚡️ -52.54% |
| **MultiHop ExactOut (3 hops)** | Gas Used | 54,358,784 | 129,684,368 | -75,325,584 | ⚡️ -58.08% |
| | Storage Diff | 14 | 104 | -90 | ⚡️ -86.54% |
| | CPU Cycles | 52,215,462 | 127,762,364 | -75,546,902 | ⚡️ -59.13% |
| **MultiRoute ExactIn (50:50 split)** | Gas Used | 35,577,074 | 73,216,009 | -37,638,935 | ⚡️ -51.41% |
| | Storage Diff | 2,849 | 3,330 | -481 | ⚡️ -14.44% |
| | CPU Cycles | 32,801,437 | 70,645,850 | -37,844,413 | ⚡️ -53.57% |
| **MultiRoute ExactOut (50:50 split)** | Gas Used | 48,010,639 | 113,717,305 | -65,706,666 | ⚡️ -57.78% |
| | Storage Diff | 2 | 2 | 0 |  0.00% |
| | CPU Cycles | 45,354,680 | 111,299,976 | -65,945,296 | ⚡️ -59.25% |
| **CollectReward (immediately after stake)** | Gas Used | 2,847,217 | 4,486,368 | -1,639,151 | ⚡️ -36.54% |
| | Storage Diff | -6 | -6 | 0 |  0.00% |
| | CPU Cycles | 1,699,909 | 3,301,492 | -1,601,583 | ⚡️ -48.51% |
| **CreateExternalIncentive** | Gas Used | 3,323,378 | 3,119,320 | +204,058 | ⚠️ 6.54% |
| | Storage Diff | 30,612 | 28,826 | +1,786 | ⚠️ 6.20% |
| | CPU Cycles | 1,614,860 | 1,853,138 | -238,278 | ⚡️ -12.86% |
| **EndExternalIncentive** | Gas Used | 1,341,967 | 1,497,591 | -155,624 | ⚡️ -10.39% |
| | Storage Diff | -5,255 | -1,988 | -3,267 | ⚡️ -164.34% |
| | CPU Cycles | 755,344 | 797,271 | -41,927 | ⚡️ -5.26% |
| **RegisterInitializer (v1)** | Gas Used | 328,425 | 598,333 | -269,908 | ⚡️ -45.11% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 35,433 | 60,237 | -24,804 | ⚡️ -41.18% |
| **RegisterInitializer (v2)** | Gas Used | 35,433 | 60,237 | -24,804 | ⚡️ -41.18% |
| | Storage Diff | 0 | 0 | 0 |  0.00% |
| | CPU Cycles | 35,433 | 60,237 | -24,804 | ⚡️ -41.18% |

---
