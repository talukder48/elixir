package elixir.spring.model;

public class UserRole {
	private String userType;
	private String userBrach;
	private String AccessRole;
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getUserBrach() {
		return userBrach;
	}
	public void setUserBrach(String userBrach) {
		this.userBrach = userBrach;
	}
	public String getAccessRole() {
		return AccessRole;
	}
	public void setAccessRole(String accessRole) {
		AccessRole = accessRole;
	}

}
