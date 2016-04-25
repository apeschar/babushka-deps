dep 'file-max' do
    file_max = 500_000
    met? {
        File.read('/proc/sys/fs/file-max').to_i >= file_max
    }
    meet {
        File.open('/etc/sysctl.d/file-max.conf', 'w') { |f|
            f.write("fs.file-max = #{file_max}\n")
        }
	shell('sysctl -p /etc/sysctl.d/file-max.conf')
    }
end
