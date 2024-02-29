local Library = {

};

function Library:ESP(ESP, Player, Color, Toggle)
    if ESP == "Box" then 
        local lp = game.Players.LocalPlayer;
        local players = game:GetService("Players");
        local camera = game:GetService("Workspace").CurrentCamera;
        local CurrentCamera = workspace.CurrentCamera;
        local worldToViewportPoint = CurrentCamera.worldToViewportPoint;

        local Headoff = Vector3.new(0,0.5,0);
        local Legoff = Vector3.new(0,3,0);

        for i,v in ipairs(Player) do 
            if players:FindFirstChild(v.Name) then 

                local BotOutline = Drawing.new("Square")
                BoxOutline.Visible = false;
                BoxOutline.Color = Color;
                BoxOutline.Thickness = 3;
                BoxOutline.Transparency = 1;
                BoxOutline.Filled = false;

                local Box = Drawing.new("Square");
                Box.Visible = false;
                Box.Color = Color;
                Box.Thickness = 1;
                Box.Transparency = 1;
                Box.Filled = false;

                function boxesp()
                    game:GetService("RunService").RenderStepped:Connect(function()
                        if v.Character ~= nil and v ~= lp and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                            local Vector, onScreen = Camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                            local RootPart = v.Character.HumanoidRootPart
                            local Head = v.Character.Head
                            local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                            local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + Headoff)
                            local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - Legoff)

                            if onScreen then
                                BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)

                                Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                            else
                                BoxOutline.Visible = false
                                Box.Visible = false
                            end;
                        else
                            BoxOutline.Visible = false
                            Box.Visible = false
                        end;
                    end);

                end;
                coroutine.wrap(boxesp)()
            end;

            game.Players.PlayerAdded:Connect(function(v)
                local BotOutline = Drawing.new("Square")
                BoxOutline.Visible = false;
                BoxOutline.Color = Color;
                BoxOutline.Thickness = 3;
                BoxOutline.Transparency = 1;
                BoxOutline.Filled = false;

                local Box = Drawing.new("Square");
                Box.Visible = false;
                Box.Color = Color;
                Box.Thickness = 1;
                Box.Transparency = 1;
                Box.Filled = false;

                function boxesp()
                    game:GetService("RunService").RenderStepped:Connect(function()
                        if v.Character ~= nil and v ~= lp and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                            local Vector, onScreen = Camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                            local RootPart = v.Character.HumanoidRootPart
                            local Head = v.Character.Head
                            local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                            local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + Headoff)
                            local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - Legoff)

                            if onScreen then
                                BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)

                                Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                            else
                                BoxOutline.Visible = false
                                Box.Visible = false
                            end;
                        else
                            BoxOutline.Visible = false
                            Box.Visible = false
                        end;
                    end);

                end;
                coroutine.wrap(boxesp)()
            end);
        end;
        

    end;
end;
