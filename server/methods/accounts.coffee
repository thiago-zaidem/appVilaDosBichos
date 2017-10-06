Accounts.onCreateUser (options, user) ->
  defaultDashbordPofile = [Config.defaultProfile]

  if user.profile is undefined
    if options.profile
      user.profile = options.profile

    user.roles = defaultDashbordPofile
    return user;

Meteor.methods
	deleteAccount: (userId) ->
		if @userId == userId
			Meteor.users.remove _id: @userId