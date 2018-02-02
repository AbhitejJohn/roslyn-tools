// Copyright (c) Microsoft.  All Rights Reserved.  Licensed under the Apache License, Version 2.0.  See License.txt in the project root for license information.

#r "../../artifacts/Debug/bin/GithubMergeTool/net46/GithubMergeTool.dll"

using System;
using System.Net;
using System.Threading.Tasks;

private readonly static string GithubAuthToken = Environment.GetEnvironmentVariable("GITHUB_AUTH_TOKEN");
private readonly static string GithubUsername = Environment.GetEnvironmentVariable("GITHUB_USERNAME");

private static async Task MakeGithubPr(
    GithubMergeTool.GithubMergeTool gh,
    string repoOwner,
    string repoName,
    string srcBranch,
    string destBranch)
{
    Console.WriteLine($"Merging from {srcBranch} to {destBranch}");

    var result = await gh.CreateMergePr(repoOwner, repoName, srcBranch, destBranch);

    if (result != null)
    {
        if (result.StatusCode == (HttpStatusCode)422)
        {
            Console.WriteLine("PR not created -- all commits are present in base branch");
        }
        else
        {
            Console.WriteLine($"Error creating PR. GH response code: {result.StatusCode}");
        }
    }
    else
    {
        Console.WriteLine("PR created successfully");
    }
}

private static async Task RunAsync()
{
    // Write your test code here to test changes to the merge tool DLL
    var gh = new GithubMergeTool.GithubMergeTool(GithubUsername, GithubAuthToken);

    var result = await gh.MergePrIfEligible("agocke", "roslyn", "5");
    Console.WriteLine("result: " + result.merged);
    Console.WriteLine("error: " + result.error ?? "null");
}

RunAsync().GetAwaiter().GetResult();
