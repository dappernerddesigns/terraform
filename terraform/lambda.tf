resource "aws_lambda_function" "s3_file_reader" {
filename = "${path.module}/../function.zip"
function_name = "${var.lambda_name}"
role = aws_iam_role.lambda_role.arn
handler = "reader.lambda_handler"
runtime = "python3.8"
depends_on =[aws_iam_role_policy_attachment.lambda_s3_policy_attachment, aws_iam_role_policy_attachment.lambda_cw_policy_attachment]
}

resource "aws_lambda_permission" "allow_s3" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_file_reader.function_name
  principal = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.data_bucket.arn
  source_account = data.aws_caller_identity.current.account_id
}