| Name | Gas Used | Storage Diff | CPU Cycles |
|------|----------|--------------|------------|
| TickMathGetSqrtRatioAtTick (minTick) | 1,554,252 | 0 | 677,324 |
| TickMathGetSqrtRatioAtTick (maxTick) | 873,832 | 0 | 863,400 |
| TickMathGetSqrtRatioAtTick (zero) | 134,165 | 0 | 134,165 |
| TickMathGetSqrtRatioAtTick | 652,288 | 0 | 641,936 |
| TickMathGetTickAtSqrtRatio | 1,792,151 | 0 | 1,635,447 |
| GetLiquidityForAmounts | 1,442,983 | 0 | 1,422,279 |
| GetAmountsForLiquidity | 1,333,931 | 0 | 1,333,931 |
| LiquidityMathAddDelta (positive) | 231,282 | 0 | 198,242 |
| LiquidityMathAddDelta (negative) | 211,276 | 0 | 211,276 |
| LiquidityMathAddDelta | 198,242 | 0 | 198,242 |
| ExistsUserSendCoins | 288,858 | 0 | 18,206 |
| GetAmount0Delta | 3,945,226 | 0 | 1,486,687 |
| GetAmount1Delta | 1,050,599 | 0 | 1,040,247 |
| SwapMathComputeSwapStep | 1,879,867 | 0 | 1,859,003 |
| Propose Community Pool Spend | 2,814,069 | 13,409 | 1,204,473 |
| Propose Parameter Change | 2,573,575 | 12,390 | 1,808,263 |
| Vote | 1,145,651 | 2,064 | 916,541 |
| Execute | 4,044,174 | 76 | 533,869 |
| Propose Text | 1,378,050 | 11,191 | 1,046,978 |
| Propose Text with Inactive: 100 | 2,175,133 | 11,693 | 1,420,800 |
| CollectUndelegatedGns (100 delegations, 1 withdraws) | 38,744,498 | 0 | 33,252,780 |
| CollectUndelegatedGns (10 delegations, 10 withdraws) | 4,396,533 | 0 | 3,773,715 |
| CollectUndelegatedGns (10 delegations, 1 withdraws) | 1,784,463 | 0 | 1,161,645 |
| CollectUndelegatedGns (10 delegations, 50 withdraws) | 16,008,273 | 0 | 15,382,915 |
| CollectUndelegatedGns (10 delegations, 5 withdraws) | 2,945,383 | 0 | 2,322,565 |
| CollectUndelegatedGns (1 delegation, 10 withdraws) | 376,920 | 0 | 238,162 |
| CollectUndelegatedGns (1 delegation, 1 withdraws) | 295,047 | 0 | 156,289 |
| CollectUndelegatedGns (1 delegation, 50 withdraws) | 740,880 | 0 | 602,042 |
| CollectUndelegatedGns (1 delegation, 5 withdraws) | 331,435 | 0 | 192,677 |
| CollectReward (100 delegations, 1 withdraws) | 1,356,656 | 1,384 | 842,195 |
| CollectReward (10 delegations, 10 withdraws) | 1,355,588 | 1,378 | 842,195 |
| CollectReward (10 delegations, 1 withdraws) | 1,355,240 | 1,378 | 841,847 |
| CollectReward (10 delegations, 50 withdraws) | 1,355,588 | 1,378 | 842,195 |
| CollectReward (10 delegations, 5 withdraws) | 1,355,299 | 1,378 | 841,906 |
| CollectReward (1 delegation, 10 withdraws) | 2,039,042 | 1,402 | 841,201 |
| CollectReward (1 delegation, 1 withdraws) | 2,033,934 | 1,402 | 836,093 |
| CollectReward (1 delegation, 50 withdraws) | 2,039,101 | 1,402 | 841,260 |
| CollectReward (1 delegation, 5 withdraws) | 2,039,042 | 1,402 | 841,201 |
| Delegate | 8,603,884 | 19,388 | 949,661 |
| Undelegate | 2,546,347 | 1,343 | 1,326,598 |
| Undelegate (5 delegations, cached external calls) | 7,380,969 | 5,530 | 6,212,665 |
| Delegate (cached external calls) | 2,394,510 | 10,631 | 1,330,939 |
| Undelegate (early exit, 3 of 10 delegations) | 5,128,308 | 3,324 | 4,155,784 |
| Redelegate | 3,642,851 | 10,868 | 2,168,194 |
| Redelegate (50 of 100 delegations, optimized) | 73,767,977 | 10,915 | 65,820,256 |
| Undelegate (50 delegatees, large AVL traversal) | 2,378,209 | 1,142 | 1,447,979 |
| Launchpad CollectDepositGns | 2,371,937 | -1,903 | 1,330,942 |
| CollectProtocolFee (1 token) | 1,453,781 | 3,433 | 916,178 |
| CollectProtocolFee (2 tokens) | 2,123,728 | 6,832 | 1,411,191 |
| CollectProtocolFee (5 tokens) | 4,170,669 | 17,020 | 2,903,292 |
| Launchpad CollectProtocolFee (tokens: 10) | 7,571,315 | 34,261 | 5,369,522 |
| Launchpad CollectRewardByDepositId | 1,011,509 | 2,047 | 559,865 |
| Create Launchpad Project | 9,156,353 | 29,194 | 1,847,409 |
| Launchpad DepositGns | 6,251,707 | 12,161 | 1,368,219 |
| Launchpad TransferLeftFromProjectByAdmin | 1,319,030 | 5 | 452,250 |
| CreatePool | 7,253,273 | 16,880 | 2,306,113 |
| Mint (fee:3000, wide range) | 17,801,189 | 28,130 | 11,627,119 |
| Swap (gns -> wugnot, fee:500) | 31,800,989 | 19,876 | 19,727,025 |
| DecreaseLiquidity | 15,644,759 | -2,081 | 13,286,830 |
| IncreaseLiquidity | 11,491,084 | -2,102 | 10,608,190 |
| Mint (bar:foo:500) | 21,222,232 | 28,123 | 10,700,302 |
| CollectFee (with unwrap) | 6,196,957 | 4,376 | 3,002,270 |
| DecreaseLiquidity (w. Remove) | 14,743,469 | 4,380 | 11,002,915 |
| Mint (reposition) | 12,203,506 | 21,203 | 10,784,198 |
| SetPoolTier (tier 1) | 4,541,230 | 21,548 | 1,449,066 |
| StakeToken | 9,838,872 | 23,549 | 6,095,409 |
| ExactInSingleSwapRoute(grc20) - fee:10000 | 29,302,903 | 5,039 | 10,528,249 |
| ExactInSingleSwapRoute(grc20) - fee:100 | 31,352,078 | 7,874 | 12,575,360 |
| ExactInSingleSwapRoute(grc20) - fee:3000 | 29,738,307 | 5,041 | 10,539,388 |
| ExactInSingleSwapRoute(grc20) - fee:500 | 29,183,950 | 5,039 | 10,450,688 |
| ExactInSwapRoute(grc20) - fee:10000 | 29,040,344 | 5,039 | 10,265,690 |
| ExactInSwapRoute(grc20) - fee:100 | 31,096,063 | 7,874 | 12,319,345 |
| ExactInSwapRoute(grc20) - fee:3000 | 29,479,020 | 5,041 | 10,280,101 |
| ExactInSwapRoute(grc20) - fee:500 | 28,927,935 | 5,039 | 10,194,673 |
| ExactOutSingleSwapRoute(grc20) - fee:10000 | 30,097,615 | 5,039 | 11,333,313 |
| ExactOutSingleSwapRoute(grc20) - fee:100 | 32,076,745 | 7,874 | 13,310,379 |
| ExactOutSingleSwapRoute(grc20) - fee:3000 | 30,467,558 | 5,041 | 11,289,343 |
| ExactOutSingleSwapRoute(grc20) - fee:500 | 29,927,934 | 5,039 | 11,215,376 |
| ExactOutSwapRoute(grc20) - fee:10000 | 29,846,344 | 5,039 | 11,082,042 |
| ExactOutSwapRoute(grc20) - fee:100 | 31,832,018 | 7,874 | 13,065,652 |
| ExactOutSwapRoute(grc20) - fee:3000 | 30,219,559 | 5,041 | 11,041,344 |
| ExactOutSwapRoute(grc20) - fee:500 | 29,683,207 | 5,039 | 10,970,649 |
| BuildSingleHopRoutePath | 1,743,185 | 0 | 23,398 |
| MultiHop ExactIn (2 hops) | 30,632,647 | 10,748 | 20,929,968 |
| MultiHop ExactOut (2 hops) | 33,889,293 | 26 | 32,322,403 |
| MultiHop ExactIn (3 hops) | 32,745,718 | 5,745 | 30,429,272 |
| MultiHop ExactOut (3 hops) | 51,786,701 | 14 | 49,648,211 |
| MultiRoute ExactIn (50:50 split) | 33,016,876 | 2,867 | 30,243,959 |
| MultiRoute ExactOut (50:50 split) | 45,456,789 | 2 | 42,804,174 |
| CollectReward (immediately after stake) | 4,082,773 | -6 | 2,932,633 |
| CreateExternalIncentive | 3,111,315 | 30,770 | 1,641,677 |
| EndExternalIncentive | 1,361,189 | -5,300 | 773,670 |
| RegisterInitializer (v1) | 328,756 | 0 | 35,764 |
| RegisterInitializer (v2) | 35,764 | 0 | 35,764 |
