defmodule NetworkScanner do
  def scan_network(network_address) do
    # Define the options for the nmap command
    options = ["-sn", "#{network_address}/24"]

    # Execute the nmap command and capture the output
    output = System.cmd("nmap", options)

    # Parse the output to extract the list of hosts that responded to the ping scan
    hosts = extract_hosts(output)

    # Print the list of hosts
    IO.puts("Hosts on the network:")
    Enum.each(hosts, fn(host) -> IO.puts(host) end)
  end

  defp extract_hosts(output) do
    # Split the output into lines and filter out any that don't contain a host address
    lines = output |> String.split("\n") |> Enum.filter(fn(line) -> String.match?(line, /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/) end)

    # Extract the host addresses from the lines
    hosts = lines |> Enum.map(fn(line) -> String.split(line, " ")[4] end)

    # Return the list of hosts
    hosts
  end
end

# Run the network scan
NetworkScanner.scan_network("192.168.1.0")
