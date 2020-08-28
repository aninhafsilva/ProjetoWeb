<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="config.Conexao"%>
<!DOCTYPE html>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="css/estilo.css" rel="stylesheet"> 
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<html>
    <head>
        <title>Login</title>
    </head>
    <%
      
        Statement st = null;
        ResultSet rs = null;
    %>
    <body>
        <div id="login">

            <div class="container">
                <div id="login-row" class="row justify-content-center align-items-center">
                    <div id="login-column" class="col-md-6">
                        <div id="login-box" class="col-md-12">
                            <form id="login-form" class="form" action="index.jsp" method="post">
                                <h3 class="text-center text-info">Login</h3>
                                <div class="form-group">
                                    <label for="username" class="text-info">Usuário:</label><br>
                                    <input type="text" name="txtUsuario" id="txtUsuario" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="text-info">Senha:</label><br>
                                    <input type="password" name="txtSenha" id="txtSenha" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="remember-me" class="text-info"><span>Lembrar-me</span> <span><input id="remember-me" name="remember-me" type="checkbox"></span></label><br>
                                    <input type="submit" name="submit" class="btn btn-info btn-md" value="Logar">
                                </div>
                                <div id="register-link" class="text-right">
                                    <a href="#" class="text-info">Cadastre-se</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <p align="center" class="text-center mt-2">
                    <%
                        String usuario = request.getParameter("txtUsuario");
                        String senha = request.getParameter("txtSenha");
                        String nomeUsuario = "";
                        String user = "";
                        String pass = "";

                        int i = 0;

                        if (usuario == null || senha == null) {
                            out.println("Preencha os Dados");
                        } else {
                            try {
                                
                                st = new Conexao().conectar().createStatement();
                                rs = st.executeQuery("SELECT * FROM usuario where usuario = '" + usuario + "' and '" + senha + "'");
                                while (rs.next()) {
                                    user = rs.getString(3);
                                    pass = rs.getString(4);
                                    nomeUsuario = rs.getString(2);
                                    rs.last();
                                    i = rs.getRow();
                                }
                            } catch (Exception e) {
                                out.print(e);
                            }

                            if (usuario.equals(user) && senha.equals(pass)) { //
                                session.setAttribute("nomeUsuario", nomeUsuario);
                                response.sendRedirect("usuarios.jsp");
                            } else {
                                out.println("Dados Incorretos");
                            }
                        }
                    %>
                </p>
            </div>
        </div>
    </body>
</html>



