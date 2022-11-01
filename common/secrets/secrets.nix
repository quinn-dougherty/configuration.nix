let
  root-fw-ed25519 =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhxTk+YQ1wNcLsk6GH9HwWdtPuAEGtD+FoNk094em5F";
  root-fw-rsa =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDUzOfJxaoFeIUI9Slak4ZdiVfzXlpO3nFaNE07y9hmftWINXMDkuCBSgolMj0vTGRh0GeHYzvkC3YFy+TnJL2iooDcg6+MGBrk/3zQtj7RtCnny4GdQvkQeljKW3Urz5kJtyRuWIft45AeKUyXjrqeurLDSotoxUTrkzfruUejB/+c+avR7KCmFJnPPAt+xOP/Y7OtSjaGol2v2/fL8EyBzwoxeJLSmYzfGu6+HjoRePRtkclWlWhSc9YdbsjiMhhjXVr+jlgscMStn5oPUbaicjqhMj8Sol0ycegmzZCGvS/xyEyUSduEkctgynagfz1Y35nq3Fy/LrlNzIugqcy6MaO1z9l0653SDvTitj+i6m9ZaLiYfftIG30g/pw1it+QyPBJdgT/Sj+fR7RbYURPpsUoM8UwoQYVwIM7ANswz0MgRrmEYS/9SqQTz0bHFCa63IrM8kHm4dm5Wz6dekGKy2ZoRFPVIec4tXA0LxLBIusI1+IPjjqpR/0orl/1nckOP2TthrVDzCV0ZOL6PQRdjmcjmKqFqYra6QJ3vbiTsWS3phm5fY5gaF9QRUDwsXFJSbk01u/lJfaU9DSz8f/VfPc9nS8UTCCX2P5fWjr7w4SqsKUARuU8bn246Aq4iDQtpJpeZdwqbOO5B3XS+iKbjZW+OXxBUpn7DwZq1iWGQ==";
  root-hercagentlatitude-ed25519 =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDetSZCNpsx5amwU9cYbcAl4CLC3yprDTuHUX9h06CC1";
  root-hercagentlatitude-rsa =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDXQkyNrRwb0JyHXBrhv4dSfcmx5vFF7k1PEsVI9k3i3yeCsNF9vMcNrs0/8Gxk6t69HgaiWH0SwPNJXf2GWs4e8u2SDjh+hSfMmyfLM6jv8jou+NjJS7n2n4IQMUavEZVK7+1SsL3gyS/DK2wqY6ZVJOXYs0ZuQngLg0fJkZWess7uSqGkwW18OAfEFcVG9yhBLeZ6DqEWY21rWu7Ws/YVZR5R7Eia8AFN+ysgVYhjditEkYIqsf2ndlxZtHre4SUqG5CsnD+tLhsUp35GLA+FxOr9nyTCFy7OiUA8Ahmq/P4znxdo0frKM9fRkIahEtCMnl49IXnj+KC/zaYnt6h4q8rBL4sMtzm4Gho35mKVAzlupSN1IL2Sed6YcPU5sFqPlTdPrEdWSrd/6kTg5KY6SbUQtmOpfGPe4uKA8tMMUmKzDbzxNWfzpGlWt9RXiTuti5SFb1f4aT8c3Cvlcg4tmv40IyMNvxRgx66sdc5Ol6YQ1BQwy1U5Ek2znBebaiOWQa5JdAALRdYjd3Ra1tzMORwuR3klXQBu2h2IsQzBk6/0tm9Y9TI0vH8MAupj9dRElkmbJP5bWksVWdczj44tlifhADK1xmelfUBTAqhc6a58bTr64sGO3Tnd4ZjggtkVgADebHmAVQuz/PVaUopj7Xglba0bpZ0CPUomxdo12Q==";
  root-users = [
    root-fw-ed25519
    root-fw-rsa
    root-hercagentlatitude-ed25519
    root-hercagentlatitude-rsa
  ];
in { "factorio.age".publicKeys = root-users; }
