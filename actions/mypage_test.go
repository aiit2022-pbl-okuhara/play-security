package actions

func (as *ActionSuite) Test_MypageHandler() {
	res := as.HTML("/mypage").Get()
	as.Equal(302, res.Code)
	as.Equal(res.Location(), "/auth/new")
}
