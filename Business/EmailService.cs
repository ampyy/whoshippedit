using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;

namespace whoshippedit.Business;

public interface IEmailService
{
    Task SendMagicLinkAsync(string toEmail, string magicLinkUrl);
}

/// <summary>
/// In development: logs the magic link to the console.
/// In production:  sends via SMTP (works with Resend, Mailgun, SendGrid, Gmail, etc.)
/// </summary>
public class EmailService : IEmailService
{
    private readonly IConfiguration _config;
    private readonly IHostEnvironment _env;
    private readonly ILogger<EmailService> _logger;

    public EmailService(IConfiguration config, IHostEnvironment env, ILogger<EmailService> logger)
    {
        _config = config;
        _env = env;
        _logger = logger;
    }

    public async Task SendMagicLinkAsync(string toEmail, string magicLinkUrl)
    {
        if (_env.IsDevelopment())
        {
            // In dev log it for convenience, but still send it!
            _logger.LogWarning("═══════════════════════════════════════");
            _logger.LogWarning("MAGIC LINK (dev mode — sending via SMTP):");
            _logger.LogWarning("{Url}", magicLinkUrl);
            _logger.LogWarning("═══════════════════════════════════════");
        }

        var message = new MimeMessage();
        message.From.Add(new MailboxAddress(
            _config["Email:FromName"] ?? "WhoShippedIt",
            _config["Email:FromAddress"] ?? throw new InvalidOperationException("Email:FromAddress not set")));
        message.To.Add(MailboxAddress.Parse(toEmail));
        message.Subject = "Your sign-in link for WhoShippedIt";

        message.Body = new TextPart("html")
        {
            Text = $"""
            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #111111; width: 100%; margin: 0; padding: 40px 20px;">
              <tr>
                <td align="center">
                  <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #181818; border: 1px solid #262626; border-radius: 12px; max-width: 520px; width: 100%;">
                    <!-- Header -->
                    <tr>
                      <td style="padding: 32px 32px 20px 32px;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; font-size: 14px; font-weight: 500; color: #ffffff; letter-spacing: -0.3px;">
                              WhoShippedIt
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <div style="border-top: 1px solid #262626; height: 1px; line-height: 1px; font-size: 1px; margin: 0 32px;"></div>
                      </td>
                    </tr>
                    <!-- Main Section -->
                    <tr>
                      <td style="padding: 32px 32px 24px 32px;">
                        <h1 style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; font-size: 20px; font-weight: 500; color: #ffffff; margin: 0 0 12px 0; line-height: 1.3;">
                          Sign in to WhoShippedIt
                        </h1>
                        <p style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; font-size: 13px; font-weight: 400; color: #a0a0a0; margin: 0 0 24px 0; line-height: 1.6;">
                          Use the secure link below to access your account. This link expires in 15 minutes and can only be used once.
                        </p>
                        
                        <!-- Button -->
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                              <a href="{magicLinkUrl}" style="display: block; width: 100%; background-color: #ffffff; border-radius: 8px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; font-size: 14px; font-weight: 500; color: #111111; text-align: center; text-decoration: none; line-height: 48px; height: 48px;">
                                Sign in
                              </a>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <!-- Fallback Section -->
                    <tr>
                      <td style="padding: 0 32px 24px 32px;">
                        <p style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; font-size: 11px; font-weight: 400; color: #737373; margin: 0 0 8px 0; line-height: 1.5;">
                          If the button doesn't work, copy and paste this link into your browser.
                        </p>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #111111; border: 1px solid #262626; border-radius: 6px; width: 100%;">
                          <tr>
                            <td style="padding: 12px; font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Monaco, Consolas, monospace; font-size: 11px; line-height: 1.5; word-break: break-all; white-space: pre-wrap;">
                              <a href="{magicLinkUrl}" style="color: #8b8bff; text-decoration: none; word-break: break-all; font-family: inherit;">{magicLinkUrl}</a>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <!-- Security Section -->
                    <tr>
                      <td style="padding: 0 32px 32px 32px;">
                        <table cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
                          <tr>
                            <td style="width: 16px; vertical-align: middle;" valign="middle">
                              <span style="font-size: 13px; line-height: 13px; color: #737373; display: inline-block;">🛡</span>
                            </td>
                            <td style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; font-size: 11px; font-weight: 400; color: #737373; line-height: 1.4; padding-left: 8px; vertical-align: middle;" valign="middle">
                              This sign-in link expires in 15 minutes and can only be used once.
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <div style="border-top: 1px solid #262626; height: 1px; line-height: 1px; font-size: 1px; margin: 0 32px;"></div>
                      </td>
                    </tr>
                    <!-- Footer -->
                    <tr>
                      <td style="padding: 24px 32px 32px 32px;">
                        <p style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; font-size: 11px; font-weight: 400; color: #737373; margin: 0 0 6px 0; line-height: 1.5;">
                          If you didn't request this email, you can safely ignore it.
                        </p>
                        <p style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; font-size: 11px; font-weight: 400; color: #525252; margin: 0; line-height: 1.5;">
                          &copy; 2026 WhoShippedIt. All rights reserved.
                        </p>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            """
        };

        using var client = new SmtpClient();
        await client.ConnectAsync(
            _config["Email:SmtpHost"] ?? throw new InvalidOperationException("Email:SmtpHost not set"),
            int.Parse(_config["Email:SmtpPort"] ?? "587"),
            SecureSocketOptions.StartTls);

        await client.AuthenticateAsync(
            _config["Email:SmtpUser"] ?? throw new InvalidOperationException("Email:SmtpUser not set"),
            _config["Email:SmtpPassword"] ?? throw new InvalidOperationException("Email:SmtpPassword not set"));

        await client.SendAsync(message);
        await client.DisconnectAsync(true);

        _logger.LogInformation("Magic link email sent to {Email}", toEmail);
    }
}
