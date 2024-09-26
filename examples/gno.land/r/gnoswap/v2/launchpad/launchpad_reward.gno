package launchpad

// BELOW LOGIC is for each project's recipient
/*
	`launchpad` contract will have xGNS because of deposit
	Therefore when claiming reward from protocol fee, launchpad will get some
	These rewards should be distributed to the recipients of the projects


	# re-use gov'stakers reward calculation logic
	https://github.com/gnoswap-labs/gnoswap/blob/8efa646a76024af74f3920d5b15a01f8ab1d937c/gov/staker/reward_calculation.gno#L40-L69

*/

// BELOW LOGIC is for users who made deposit
func ClaimReward() {
	// project token
	// calculate amount and claim
	//  > reward per block for each project's each tier
	//  > ratio of user's deposit amount to total deposit amount of the tier

	/*
		alreadyClaimed := 0
		for _, deposit := range depositHistory[std.GetCaller()] {
			// calculate reward
			// claim reward
			alreadyClaimed += deposit.reward
		}
	*/

}

func GetClaimableReward() string { // return in json format
	// for each deposit
}
