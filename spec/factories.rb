Factory.define :user do |user|
	user.name           "denzelGent"
	user.email					"denzelgent@gm.com"
	user.password				"foobar"
	user.password_confirmation	"foobar"
end

	
Factory.sequence :email do |n| 
  "person-#{n}@example.com"
end