import java.sql.DriverManager
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress
import java.time.LocalDateTime


fun receiveMessage() {
    val porta = 9876
    val tamanhoBuffer = 1024
    Thread {
        try {

            val socket = DatagramSocket(porta)
            val buffer = ByteArray(tamanhoBuffer)

            val pacote = DatagramPacket(buffer, buffer.size)
            println("Aguardando pacote...")
            socket.receive(pacote)


            val mensagemRecebida = String(pacote.data, 0, pacote.length)
            println("Mensagem recebida: $mensagemRecebida")
            if (mensagemRecebida.isNotEmpty()){
                insertIridiumMessage(mensagemRecebida)
            }


            //socket.close()

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }.start()
}
fun insertIridiumMessage(message : String) {
    val jdbcUrl = "jdbc:postgresql://18.231.125.54:5432/postgres"
    val username = "postgres"
    val password = "postgres"


    try {
        Class.forName("org.postgresql.Driver")

        // Estabelecer a conexão com o banco de dados
        val connection = DriverManager.getConnection(jdbcUrl, username, password)
        val statement = connection.createStatement()
        //select no banco
        val resultSet = statement.executeQuery("SELECT * FROM iridium")
        while (resultSet.next()) {
            val column1Value = resultSet.getString("MESSAGE")
            val column2Value = resultSet.getString("reception_datetime")
            // Faça algo com os valores recuperados, por exemplo, imprima-os na tela
            println("MESSAGE: $column1Value, RECEPTION_DATETIME: $column2Value")
        }

        //insert no banco
        val insertQuery = "INSERT INTO iridium (\"MESSAGE\", reception_datetime) VALUES (?, ?)"
        val preparedStatement = connection.prepareStatement(insertQuery)

        preparedStatement.setString(1, message)
        preparedStatement.setObject(2, LocalDateTime.now())

        val rowsAffected = preparedStatement.executeUpdate()

        println("$rowsAffected linha(s) afetada(s).")

        // Fechar a conexão e o statement
//        preparedStatement.close()
//        connection.close()

    } catch (e: Exception) {
        e.printStackTrace()
    }
}

fun main() {
//    insertIridiumMessage("testando")
    receiveMessage()
}



