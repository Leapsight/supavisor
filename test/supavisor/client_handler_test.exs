defmodule Supavisor.ClientHandlerTest do
  use ExUnit.Case, async: true

  alias Supavisor.ClientHandler

  describe "parse_user_info/1" do
    test "extracts the external_id from the username" do
      username = "test.user.external_id"
      {name, external_id} = ClientHandler.parse_user_info(username)
      assert name == "test.user"
      assert external_id == "external_id"
    end

    test "username consists only of external_id" do
      username = "external_id"
      {nil, external_id} = ClientHandler.parse_user_info(username)
      assert external_id == "external_id"
    end
  end
end
