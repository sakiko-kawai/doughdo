import { createClient } from "https://esm.sh/@supabase/supabase-js@2.14.0";

console.log("Hello from Functions!");

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }
  try {
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      {
        global: {
          headers: { Authorization: req.headers.get("Authorization")! },
        },
      },
    );

    const {
      data: { user },
    } = await supabaseClient.auth.getUser();
    console.log(user);

    if (user == null) throw Error;

    const supabaseAdmin = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "",
    );

    const { data: data, error: images_error } = await supabaseClient.from(
      "record",
    )
      .select("images").eq("user_id", user.id);
    if (images_error) throw images_error;

    let imagesArray: string[] = [];
    data.forEach((item) => {
      imagesArray = imagesArray.concat(JSON.parse(item.images));
    });
    if (imagesArray.length != 0) {
      await supabaseClient.storage.from("record-image").remove(imagesArray);
      console.log("Storage folder deleted", "Count:" + imagesArray.length);
    }

    await supabaseClient.from("record").delete().eq("user_id", user.id);
    console.log("Record deleted");

    const { data: deleted_user, error: delete_error } = await supabaseAdmin.auth
      .admin.deleteUser(user.id);
    if (delete_error) throw delete_error;
    console.log("User deleted:", deleted_user);

    return new Response(
      JSON.stringify(deleted_user, null, 2),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      },
    );
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 400,
    });
  }
});

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};
