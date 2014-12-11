#encoding: utf-8

require "csv"
CSV.open("data/errorsfile.csv", "wb") do |csv|
  csv << ["codigo", "Mensagem", "celular", "error", "error"]
  CSV.foreach('data/PlanilhaMensagemEnviadas.csv', headers: true, col_sep: "," ) do |row|
    line_with_problem = []
    ActiveRecord::Base.transaction do
      created_at = row[0]
      codigo_message = row[3]
      message_text = nil
      CSV.foreach('data/PlanilhaMensagens.csv', headers: true, col_sep: ";" ) do |row_mensagens|
        if row_mensagens[6] == row[3]
          message_text = row_mensagens[5].to_s
          break
        end
      end
      begin
        profile = CellPhone.find_by_number(row[1]).profile
        message = Message.find_by_text(message_text)

        if message.present? and profile.present?
          message_delivery = MessageDeliveries::MessageDelivery.create(created_at: created_at, message: message, child: profile.children.first)
        end
      rescue
        profile_not_find = "Celular não encontrado" if profile.nil?
        message_not_find = "Mensagem não encontrada" if message.nil?
        line_with_problem << row[3].to_s
        line_with_problem << row[2].to_s
        line_with_problem << row[1].to_s
        line_with_problem << profile_not_find
        line_with_problem << message_not_find
        csv << line_with_problem
      end
    end
  end
end
