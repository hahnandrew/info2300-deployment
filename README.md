🍴 **Forked from [TrafeX/docker-php-nginx](https://github.com/TrafeX/docker-php-nginx)**

👋 Hi there!

I made this utility for Info2300 students to help deploy their PHP web apps to the web.

To best utilize this utility, make sure you have the AWS Copilot CLI installed and a configured AWS account with the AdministratorAccess policy attached to your IAM user.

- aws iam create-user --user-name \[new-user-name\]
- aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --user-name \[new-user-name\]
- aws iam create-access-key --user-name \[new-user-name\]

Then, put all your PHP files in the src/ folder.

One addition step, make sure to change the stylesheet path in the meta partial from /styles/site.css to /public/styles/site.css

Afterwards, we can run the following commands:

```bash
copilot app init \[your-app-name\]
copilot init
```

In the following prompts, use the default options unless specified:

- When asked to choose a request: request driven web service
- When asked to choose a dockerfile: path/to/the/dockerfile/in/this/repo
- When asked to create a deploy environment: Yes

After a few minutes, you should see a URL to your web app. Congratulations! 🎉
