class MailmanSyncJob < ActiveJob::Base
  queue_as :default

  def perform(listname = nil)
    lists =
        if listname.present?
          MailingList.where(name: listname)
        else
          MailingList.all
        end
    lists.each do |list|
      cmd = "/usr/lib/mailman/bin/sync_members --file - '#{list.name}'"
      Rails.logger.info "Running: #{cmd}"
      email_list = list.users.enabled.map(&:email).join("\n")

      next if Rails.env.development? # no-op in development

      status = Open4::popen4(cmd) do |pid, stdin, stdout, stderr|
        stdin.puts(email_list)
        stdin.close

        Rails.logger.info('stdout: ' + stdout.read.strip)
        Rails.logger.warn('stderr: ' + stderr.read.strip)
      end

      unless status.success?
        Rails.logger.warn "sync_members exited dirty: #{status.inspect}"
        raise
      end
    end
  end
end