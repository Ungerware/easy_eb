module EasyEb
  class Ssh
    def self.start!(environment: nil, command: nil, ssh: nil, eb_flags: nil, env_command: "bin/ebenv", region: nil)
      bash_args = command && "-c \\\"#{env_command} #{command}\\\""
      tty_flag = command && "-t"
      ssh_flag = ssh && "-e #{ssh}"
      command_arg = [
        tty_flag,
        "cd /var/app/current; sudo bash -i #{bash_args}"
      ].compact.join(" ")

      args = [
        region && "--region #{region}",
        eb_flags,
        environment,
        ssh_flag,
        "--command \"#{command_arg}\""
      ].compact.join(" ")

      system("eb ssh #{args}", exception: true)
    end
  end
end
