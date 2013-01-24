<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login</title>
<link rel="stylesheet/less" href="../less/bootstrap.less">
<script src="../js/less.js" type="text/javascript"></script>
</head>
<style type="text/css">
html,body,#wrapper {
	height: 100%;
}

body>#wrapper {
	height: auto;
	min-height: 100%;
}
</style>
<body>
	<div class="navbar">
		<div class="navbar-inner">
			<div class="row-fluid">
				<div class="span12">
					<br /> <br />
					<div class="row-fluid">
						<div class="span6">
						<div class="logo">
						<img src = "../img/logo-large.png">
						</div>
						</div>
						<div class="span3 offset2 standout">
							<form style="color: white;" action="">
								<div class="control-group">
									<fieldset>
									<br/>
										<div class="control-group">
											<div class="controls">
												<input type="text" id="username" placeholder="Username">
											</div>
										</div>


										<div class="control-group">
											<div class="controls">
												<input type="password" id="password" placeholder="Password">
											</div>
										</div>
										
												<button type="submit" class="btn btn-info">Login</button>
												<div class="control-group">
											<div class="controls">
												<label class="checkbox"> <input type="checkbox">
													Keep me logged in
												</label>
											</div>
										</div>
									</fieldset>
								</div>
							</form>
						</div>
					</div>
					<br /> <br />
				</div>
			</div>
		</div>
	</div>
</body>
</html>